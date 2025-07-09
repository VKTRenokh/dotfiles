pragma Singleton
pragma ComponentBehavior: Bound

import "root:/modules/common"
import Quickshell
import Quickshell.Io
import Qt.labs.platform
import QtQuick

/**
 * A service for interacting with various booru APIs.
 */
Singleton {
    id: root
    property Component booruResponseDataComponent: BooruResponseData {}

    signal tagSuggestion(string query, var suggestions)

    property var systemImages: []

    property string failMessage: qsTr("That didn't work. Tips:\n- Check your tags and NSFW settings\n- If you don't have a tag in mind, type a page number")
    property var responses: []
    property int runningRequests: 0
    property var defaultUserAgent: Config.options?.networking?.userAgent || "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
    property var providerList: Object.keys(providers)
    property var providers: {
        "system": {
            "name": qsTr("System"),
            "description": qsTr("System wallpapers")
        }
    }
    property var currentProvider: Persistent.states.booru.provider

    Process {
        id: wallpaperList
        command: ["bash", "-c", "ls ~/.config/hypr/wallpapers/"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.systemImages = this.text.split("\n").filter(Boolean).map(name => {
                const path = "file:///home/vktrenokh/.config/hypr/wallpapers/" + name;

                return {
                    preview_url: path,
                    file_url: path,
                    aspect_ratio: 1
                };
            })
        }
    }

    function getWorkingImageSource(url) {
        if (url.includes('pximg.net')) {
            return `https://www.pixiv.net/en/artworks/${url.substring(url.lastIndexOf('/') + 1).replace(/_p\d+\.(png|jpg|jpeg|gif)$/, '')}`;
        }
        return url;
    }

    function setProvider(provider) {
        provider = provider.toLowerCase();
        if (providerList.indexOf(provider) !== -1) {
            Persistent.states.booru.provider = provider;
            root.addSystemMessage(qsTr("Provider set to ") + providers[provider].name + (provider == "zerochan" ? qsTr(". Notes for Zerochan:\n- You must enter a color\n- Set your zerochan username in `sidebar.booru.zerochan.username` config option. You [might be banned for not doing so](https://www.zerochan.net/api#:~:text=The%20request%20may%20still%20be%20completed%20successfully%20without%20this%20custom%20header%2C%20but%20your%20project%20may%20be%20banned%20for%20being%20anonymous.)!") : ""));
        } else {
            root.addSystemMessage(qsTr("Invalid API provider. Supported: \n- ") + providerList.join("\n- "));
        }
    }

    function clearResponses() {
        responses = [];
    }

    function addSystemMessage(message) {
        responses = [...responses, root.booruResponseDataComponent.createObject(null, {
                "provider": "system",
                "tags": [],
                "page": -1,
                "images": [],
                "message": `${message}`
            })];
    }

    function constructRequestUrl(tags, nsfw = true, limit = 20, page = 1) {
        console.log(JSON.stringify(root.systemImages) + " images");
        return "";
    }

    function makeRequest(tags, nsfw = false, limit = 20, page = 1) {
        var url = constructRequestUrl(tags, nsfw, limit, page);
        console.log("making request");
        // console.log("[Booru] Making request to " + url)

        const newResponse = root.booruResponseDataComponent.createObject(null, {
            "provider": currentProvider,
            "tags": tags,
            "page": page,
            "images": root.systemImages,
            "message": ""
        });

        root.responses = [...root.responses, newResponse];
    }

    property var currentTagRequest: null
    function triggerTagSearch(query) {
        if (currentTagRequest) {
            currentTagRequest.abort();
        }

        var provider = providers[currentProvider];
        if (provider.fixedTags) {
            root.tagSuggestion(query, provider.fixedTags);
            return provider.fixedTags;
        } else if (!provider.tagSearchTemplate) {
            return;
        }
        var url = provider.tagSearchTemplate.replace("{{query}}", encodeURIComponent(query));

        var xhr = new XMLHttpRequest();
        currentTagRequest = xhr;
        xhr.open("GET", url);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                currentTagRequest = null;
                try {
                    // console.log("[Booru] Raw response: " + xhr.responseText)
                    var response = JSON.parse(xhr.responseText);

                    response = provider.tagMapFunc(response);
                    root.tagSuggestion(query, response);
                } catch (e) {
                    console.log("[Booru] Failed to parse response: " + e);
                }
            } else if (xhr.readyState === XMLHttpRequest.DONE) {
                console.log("[Booru] Request failed with status: " + xhr.status);
            }
        };

        try {
            if (currentProvider == "danbooru") {
                xhr.setRequestHeader("User-Agent", defaultUserAgent);
            }
            xhr.send();
        } catch (error) {
            console.log("Could not set User-Agent:", error);
        }
    }
}

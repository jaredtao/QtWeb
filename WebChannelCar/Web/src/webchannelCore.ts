import { QWebChannel } from './qwebchannel';

type callback = () => void;
export default class WebChannelCore {
    public static SDK: any = undefined;
    private static connectedCb: callback;
    private static disconnectedCb: callback;
    private static socket: WebSocket;
    public static initialize(connectedCb: callback = () => { }, disconnectedCb: callback = () => { }) {
        if (WebChannelCore.SDK != undefined) {
            return;
        }
        WebChannelCore.connectedCb = connectedCb;
        WebChannelCore.disconnectedCb = disconnectedCb;
        try {
            WebChannelCore.link(
                (socket) => {
                    QWebChannel(socket, (channel: any) => {
                        WebChannelCore.SDK = channel.objects;
                        WebChannelCore.connectedCb();
                    });
                }
                , (error) => {
                    console.log("socket error", error);
                    WebChannelCore.disconnectedCb();
                });
        } catch (error) {
            console.log("socket exception:", error);
            WebChannelCore.disconnectedCb();
            WebChannelCore.SDK = undefined;
        }
    }

    private static link(resolve: (socket: WebSocket) => void, reject: (error: Event | CloseEvent) => void) {
        let baseUrl = "ws://localhost:12345";
        if (window.location.search != "") {
            baseUrl = (/[?&]webChannelBaseUrl=([A-Za-z0-9\-:/\.]+)/.exec(window.location.search)![1]);
        }
        console.log("Connectiong to WebSocket server at: ", baseUrl);

        let socket = new WebSocket(baseUrl);
        WebChannelCore.socket = socket;
        socket.onopen = () => {
            resolve(socket);
        };
        socket.onerror = (error) => {
            reject(error);
        };
        socket.onclose = (error) => {
            reject(error);
        };
    }
}
(window as any).SDK = WebChannelCore.SDK;

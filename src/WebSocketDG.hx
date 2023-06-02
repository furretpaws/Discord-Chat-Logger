import haxe.ws.WebSocket;
import haxe.ws.Types.MessageType;
import haxe.Timer;

class WebSocketDG {
    static var ws:WebSocket;
    static var timer:Timer;
    static var sequence:Int = 0;
    public static function startTheThing() {
        ws = new WebSocket("wss://gateway.discord.gg/?v=6&encoding=json");
        ws.onopen = () -> {
            trace("ws open");
            @:privateAccess
            Main.webhook.send({username: "!", content:"`Discord Gateway connection successfully initialized`"});
        }
        ws.onmessage = (m:MessageType) -> {
            switch(m) {
                case StrMessage(content):
                    incomingMessages(content);
                case BytesMessage(bytes):
                    //trace(bytes);
            }
        }
    }
    static function incomingMessages(content:String) {
        var json:Dynamic = haxe.Json.parse(content);
        var s:Int = json.s;
        var t:String = json.t;
        var d:Dynamic = json.d;
        var op:Int = json.op;
        switch(op) {
            case 10:
                //hello uwu
                timer = new Timer(d.heartbeat_interval);
                timer.run = () -> {
                    ws.send(haxe.Json.stringify({
                        op: 1, d: null
                    }));
                }
            case 11:
                //lol
            case 0:
                sequence = s;
            case 7:
                sequence = 0;
                timer.stop();
                ws.close();
                startTheThing();
        }
    }
}
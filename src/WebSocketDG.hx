import haxe.ws.WebSocket;
import haxe.ws.Types.MessageType;
import haxe.Timer;
import haxe.io.Bytes;
import haxe.io.BytesOutput;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class WebSocketDG {
    static var ws:WebSocket;
    static var timer:Timer;
    static var sequence:Int = 0;
    static var target_id:String = "";
    static var channel_names:Map<String, String> = new Map<String, String>();
    static var server_name:String = "";
    static var allowedChannels:Array<String> = ["1080541900232196116", "1066159653643354234", "1066159668558299216", "1066159662199746591", "1066159673637605516", "1066159675214680154", "1066159692155473920", "1071707851493482617", "1103416658124607548"];
    public static function startTheThing() {
        target_id = File.getContent("guild_id_target.txt");
        ws = new WebSocket("wss://gateway.discord.gg/?v=10&encoding=json");
        ws.onopen = () -> {
            trace("ws open");
            trace("uhm");
            @:privateAccess
            //Main.webhook.send({username: "!", content:"`Discord Gateway connection successfully initialized`"});
            trace("uhm");
        }
        ws.onmessage = (m:MessageType) -> {
            switch(m) {
                case StrMessage(content):
                    //trace(content);
                    incomingMessages(content, ws);
                case BytesMessage(bytes):
                    //trace(bytes);
            }
        }
    }
    static function incomingMessages(content:String, ws:WebSocket) {
        var json:Dynamic = haxe.Json.parse(content);
        var s:Int = json.s;
        var t:String = json.t;
        var d:Dynamic = json.d;
        var op:Int = json.op;
        switch(op) {
            case 10:
                //hello uwu (because op code 10 HELLO, GET IT, HAHAHAHAAH (i'm not funny))
                trace("uhm");
                haxe.EntryPoint.runInMainThread(()->{
                    timer = new Timer(d.heartbeat_interval);
                    timer.run = () -> {
                        ws.send(haxe.Json.stringify({
                            op: 1, d: null
                        }));
                    }
                });
                trace("oop");
                ws.send(haxe.Json.stringify({
                    op: 2,
                    d: {
                        token: File.getContent("token.txt"),
                        properties: {
                            os: "os",
                            browser: "a browser",
                            device: "bryn"
                        },
                        intents: 3276799
                    }
                }));
                trace("s");
            case 11:
                //lol
            case 0:
                sequence = s;
                //trace("this is opcode 0");
                //trace("and this is " + t);
                switch(t) {
                    case "READY":
                        //trace("h");
                        //Main.webhook.send({username: "!", content:"`Logged in the account, I will start logging from now`"});
                        //trace("p");
                        for (i in 0...d.guilds.length) {
                            if (d.guilds[i].id == target_id) {
                                server_name = d.guilds[i].name;
                                for (x in 0...d.guilds[i].channels.length) {
                                    channel_names.set(d.guilds[i].channels[x].id, "#"+d.guilds[i].channels[x].name);
                                }
                            }
                        }
                    case "GUILD_CREATE":
                        //trace(haxe.Json.stringify(d));
                    case "MESSAGE_CREATE":
                        //trace("yes");
                        if (d.guild_id == target_id) {
                            //trace("yes");
                            //trace(canILogThisChannel(d.channel_id));
                            if (canILogThisChannel(d.channel_id)) {
                                //funny
                                if (d.attachments.length > 0) {
                                    sys.thread.Thread.create(()->{
                                        var bytes:Array<Bytes> = [];
                                        var filenames:Array<String> = [];
                                        for (i in 0...d.attachments.length) {
                                            bytes.push(downloadFile(d.attachments[i].url));
                                            filenames.push(d.attachments[i].filename);
                                        }
                                        @:privateAccess
                                        var http:haxe.Http = Main.webhook.getHttp();
                                        http.addHeader("Content-Type", "multipart/form-data; boundary=boundary");
                                        var BO:BytesOutput = new BytesOutput();
                                        BO.writeString("--boundary\n");
                                        BO.writeString("Content-Disposition: form-data; name=\"payload_json\"\n");
                                        BO.writeString("Content-Type: application-json");
                                        BO.writeString("\n\n");
                                        var attachments:Array<Dynamic> = [];
                                        for (i in 0...filenames.length) {
                                            attachments.push({filename: filenames[i], id: i});
                                        }
                                        if (d.content == "") {
                                            BO.writeString(haxe.Json.stringify({username: d.author.username + "#" + d.author.discriminator + " ("+channel_names.get(d.channel_id)+" / "+server_name.replace("Discord", "notdisc0rd")+")", avatar_url: "https://cdn.discordapp.com/avatars/"+d.author.id+"/"+d.author.avatar+".png", content: " ", attachments: attachments}));
                                        } else {
                                            BO.writeString(haxe.Json.stringify({username: d.author.username + "#" + d.author.discriminator + " ("+channel_names.get(d.channel_id)+" / "+server_name.replace("Discord", "notdisc0rd")+")", avatar_url: "https://cdn.discordapp.com/avatars/"+d.author.id+"/"+d.author.avatar+".png", content: "`"+d.content+"`", attachments: attachments}));
                                        }
                                        for (i in 0...d.attachments.length) {
                                            //BO.writeString('\n--boundary\n');
                                            BO.writeString('Content-Disposition: form-data; name="files[' + i + ']"; filename="' + d.attachments[i].filename + '"' + "\n");
                                            BO.writeString('Content-Type: ' + hxdiscord.utils.MimeResolver.getMimeType(d.attachments[i].filename)); //idk why's base64 there but it works so i'm leaving it like that
                                            BO.writeString("\n\n");
                                            BO.writeFullBytes(bytes[i], 0, bytes[i].length);
                                            BO.writeString("\n");
                                        }
                                        BO.writeString('--boundary--');
                                        //trace(BO.getBytes().toString());
                                        http.setPostBytes(BO.getBytes());
                                        http.onData = (d:String) -> {
                                            //trace(d);
                                        }
                                        http.onError = (d:Dynamic) -> {
                                            trace(d);
                                            trace(http.responseData);
                                        }
                                        http.request(true);
                                        //trace("boom");
                                    });
                                } else {
                                    @:privateAccess
                                    var http:haxe.Http = Main.webhook.getHttp();
                                    http.addHeader("Content-Type", "application/json");
                                    http.setPostData(haxe.Json.stringify({username: d.author.username + "#" + d.author.discriminator + " ("+channel_names.get(d.channel_id)+" / "+server_name.replace("Discord", "notdisc0rd")+")", avatar_url: "https://cdn.discordapp.com/avatars/"+d.author.id+"/"+d.author.avatar+".png", content: "`"+d.content+"`"}));
                                    http.request(true);
                                }
                            }
                        }
                }
            case 7:
                sequence = 0;
                timer.stop();
                ws.close();
                startTheThing();
        }
    }

    static function canILogThisChannel(id:String) {
        var y:Bool = false;
        if (allowedChannels.contains(id)) {
            y = true;
        }
        return y;
    }

    static function downloadFile(url:String) {
        var bytes:Bytes = null;
        tink.http.Client.fetch(url).all().handle((o) -> {
            switch (o) {
                case Success(d):
                    bytes = d.body.toBytes();
                case Failure(d):
                    //failed
            }
        });
        return bytes;
    }
}
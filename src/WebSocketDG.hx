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
    static var hb_timer:Timer;
    static var sequence:Int = 0;
    static var target_id:String = "";
    static var channel_names:Map<String, String> = new Map<String, String>();
    static var server_name:String = "";
    static var resume_gateway_url:String = "wss://gateway.discord.gg/?v=10&encoding=json";
    static var session_id:String = "";
    static var interval:Int = 0;
    static var canResume:Bool = false;
    static var allowedChannels:Array<String> = ["1080541900232196116", "1066159653643354234", "1066159668558299216", "1066159662199746591", "1066159673637605516", "1066159675214680154", "1066159692155473920", "1071707851493482617", "1103416658124607548"];
    public static function startTheThing() {
        target_id = File.getContent("guild_id_target.txt");
        ws = new WebSocket(resume_gateway_url);
        ws.onopen = () -> {
            
        }
        ws.onmessage = (m:MessageType) -> {
            switch(m) {
                case StrMessage(content):
                    //trace(content);
                    incomingMessages(content);
                case BytesMessage(bytes):
                    //trace(bytes);
            }
        }
        ws.onclose = () -> {
            hb_timer.stop();
            ws = null;
            startTheThing();
        }
        ws.onerror = (err:Dynamic) -> {
            //well go fuck yourself
        }
    }
    public static function stopEverything() {
        ws.close();
        hb_timer.stop();
        ws = null;
        hb_timer = null;
        sequence = 0;
        target_id = "";
        channel_names = new Map<String, String>();
        server_name = "";
        resume_gateway_url = "wss://gateway.discord.gg/?v=10&encoding=json";
        session_id = "";
        interval = 0;
        canResume = false;
    }
    static function incomingMessages(content:String) {
        trace(content);
        var JSON:Dynamic = haxe.Json.parse(content);
        var t:String = JSON.t;
        var s:Int = JSON.s;
        var op:Int = JSON.op;
        var d:Dynamic = JSON.d;
        switch(op) {
            case 10: //"Hello" OpCode
                //hi discord uwu
                interval = d.heartbeat_interval;
                ws.send(haxe.Json.stringify({op:1, d: null})); 
                haxe.EntryPoint.runInMainThread(()->{
                    hb_timer = new haxe.Timer(interval);
                    hb_timer.run = () -> {
                        ws.send(haxe.Json.stringify({op:1, d: null})); 
                    }
                });
                if (canResume) {
                    ws.send(haxe.Json.stringify({
                        op: 6,
                        d: {
                            token: File.getContent("token.txt"),
                            session_id: session_id,
                            seq: sequence
                        }
                    }));
                } else {
                    ws.send(haxe.Json.stringify({
                        "op": 2,
                        "d": {
                                "token": File.getContent("token.txt"),
                                "properties": {
                                    "os": "a",
                                    "browser": "B",
                                    "device": "C"
                                },
                            // This intent represents 1 << 0 for GUILDS, 1 << 1 for GUILD_MEMBERS, and 1 << 2 for GUILD_BANS
                            // This connection will only receive the events defined in those three intents
                            "intents": 3276799
                        }
                    }));
                }
            case 9:
                ws.close();
                //no, we cannot resume
                canResume = false;
            case 7:
                ws.close();
            case 0:
                sequence = s;
                //trace("This is " + t);
                switch(t) {
                    case "READY":
                        //trace("h");
                        //Main.webhook.send({username: "!", content:"`Logged in the account, I will start logging from now`"});
                        //trace("p");
                        session_id = d.session_id;
                        canResume = true;
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
                        switch (d.content) {
                            case "close ws, now":
                                ws.close();
                        }
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
                                            if (Main.showMessageUrl) {
                                                BO.writeString(haxe.Json.stringify({username: d.author.username + "#" + d.author.discriminator + " ("+channel_names.get(d.channel_id)+" / "+server_name.replace("Discord", "notdisc0rd")+")", avatar_url: "https://cdn.discordapp.com/avatars/"+d.author.id+"/"+d.author.avatar+".png", content: " ", attachments: attachments, "embeds": [
                                                    {
                                                        "fields": [
                                                            {
                                                                "name": "Message URL",
                                                                "value": "https://discord.com/channels/"+d.guild_id+"/"+d.channel_id+"/"+d.id,
                                                                "inline": false
                                                            }
                                                        ]
                                                    }
                                                ]}));
                                            } else {
                                                BO.writeString(haxe.Json.stringify({username: d.author.username + "#" + d.author.discriminator + " ("+channel_names.get(d.channel_id)+" / "+server_name.replace("Discord", "notdisc0rd")+")", avatar_url: "https://cdn.discordapp.com/avatars/"+d.author.id+"/"+d.author.avatar+".png", content: " ", attachments: attachments}));
                                            }
                                        } else {
                                            trace(Main.showMessageUrl);
                                            if (Main.showMessageUrl) {
                                                BO.writeString(haxe.Json.stringify({username: d.author.username + "#" + d.author.discriminator + " ("+channel_names.get(d.channel_id)+" / "+server_name.replace("Discord", "notdisc0rd")+")", avatar_url: "https://cdn.discordapp.com/avatars/"+d.author.id+"/"+d.author.avatar+".png", content: "`"+d.content+"`", "embeds": [
                                                    {
                                                        "fields": [
                                                            {
                                                                "name": "Message URL",
                                                                "value": "https://discord.com/channels/"+d.guild_id+"/"+d.channel_id+"/"+d.id,
                                                                "inline": false
                                                            }
                                                        ]
                                                    }
                                                ]}));
                                            } else {
                                                BO.writeString(haxe.Json.stringify({username: d.author.username + "#" + d.author.discriminator + " ("+channel_names.get(d.channel_id)+" / "+server_name.replace("Discord", "notdisc0rd")+")", avatar_url: "https://cdn.discordapp.com/avatars/"+d.author.id+"/"+d.author.avatar+".png", content: "`"+d.content+"`"}));
                                            }
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
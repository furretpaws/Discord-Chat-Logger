import hxdiscord.types.ApplicationCommand;
import hxdiscord.DiscordClient;
import hxdiscord.types.Interaction;
import hxdiscord.types.Message;
import hxdiscord.endpoints.Endpoints;
import sys.io.File;
import sys.FileSystem;
import hxdiscord.types.CommandType;
import hxdiscord.utils.Intents;
import haxe.Json;
using StringTools;

#if cpp
@:cppFileCode('
#include <windows.h>
')
#end

class Main {
	static var BotClient:DiscordClient;
	static var webhook:WebhookSender = null;
	static var bot_token:String = "";
	public static var showMessageUrl:Bool = true;
	static function main() {
		if (FileSystem.exists("webhook.txt")) {
			webhook = new WebhookSender(File.getContent("webhook.txt"));
		}
		if (FileSystem.exists("token.txt") && FileSystem.exists("guild_id_target.txt")) {
			WebSocketDG.startTheThing();
		}
		if (!FileSystem.exists("config.json")) {
			File.saveContent("config.json", haxe.Json.stringify(
				{
					bot_token: ""
				}
			, "\t"));
			#if cpp
			untyped __cpp__('MessageBoxA(NULL, "A new config.json file has been generated, edit the file and open the program again.\\n\\nCheck https://github.com/FurretDev/Discord-Chat-Logger for more information", "Edit the config.json file", MB_ICONEXCLAMATION);');
			#else
			throw "A new config.json file has been generated, edit the file and open the program again.\n\nCheck https://github.com/FurretDev/Discord-Chat-Logger for more information";
			#end
			Sys.exit(0);
		}
		Sys.println('[NOTE] If you don\'t see the "successfully started" message this is due to an issue with your token. Check these steps to reassure everything is okay');
		Sys.println('1. Check that the intents "Presence Intent", "Server Member Intent" and "Message Content Intent" are enabled in your bot. You can change this on the Discord Developer Portal');
		Sys.println('2. Check that if your token is not invalid or expired');
		Sys.println('3. Check if you have internet (This sounds stupid but it is possible for that to happen)');
		Sys.println('');
		BotClient = new DiscordClient("MTEyODAyNjI0NjA4MTY3OTM3MA.GQ2uU5.", [Intents.ALL], false);
		BotClient.onReady = () -> {
			Sys.println('[Discord Chat Logger] Successfully initialized as ${BotClient.user.username}');
			var setTargetServer:ApplicationCommand = new ApplicationCommand();
			setTargetServer.setName("set_target");
			setTargetServer.setDescription("Set a guild ID to be the new target");
			setTargetServer.addOption({
				name: "id",
				description: "Guild ID",
				type: CommandType.STRING,
				required: true
			});
			setTargetServer.default_member_permissions = "0";
			var setToken:ApplicationCommand = new ApplicationCommand();
			setToken.setName("set_token");
			setToken.setDescription("Set a token to make it log all messages");
			setToken.addOption({
				name: "token",
				description: "The token (bruh)",
				type: CommandType.STRING,
				required: true
			});
			setToken.default_member_permissions = "0";
			var setWebhook:ApplicationCommand = new ApplicationCommand();
			setWebhook.setName("set_webhook");
			setWebhook.setDescription("Set a webhook URL to send the logged messages");
			setWebhook.addOption({
				name: "webhook",
				description: "Webhook URL",
				type: CommandType.STRING,
				required: true
			});
			setWebhook.default_member_permissions = "0";
			var reload:ApplicationCommand = new ApplicationCommand();
			reload.setName("reload");
			reload.setDescription("If you made some changes to the bot, you can reload the entire logger with the new configuration set");
			reload.default_member_permissions = "0";
			BotClient.setInteractionCommands([setTargetServer, setToken, setWebhook, reload]);
		}
		BotClient.onInteractionCreate = (i:Interaction) -> {
			switch(i.name) {
				case "set_target":
					File.saveContent("guild_id_target.txt", i.getValue("id"));
					i.reply({content:"Target changed successfully"}, true);
				case "set_token":
					File.saveContent("token.txt", i.getValue("token"));
					i.reply({content:"Token changed successfully"}, true);
				case "set_webhook":
					File.saveContent("webhook.txt", i.getValue("webhook"));
					i.reply({content:"Webhook changed successfully"}, true);
					webhook = new WebhookSender(File.getContent("webhook.txt"));
					webhook.send({username: "!", content: "`The webhook has been successfully configured`"});
				case "reload":
					WebSocketDG.stopEverything();
					WebSocketDG.startTheThing();
					i.reply({content:"Logger reloaded successfully"});	
			}
		}
		BotClient.onMessageCreate = (m:Message) -> {
			if (m.content.contains("<@"+BotClient.user.id+">")) {
				Endpoints.triggerTypingIndicator(m.channel_id);
				haxe.Timer.delay(()->{
					m.reply({content:"stop pinging me i'm too busy!!!"}, true);
				}, 3000);
			}
		}
		BotClient.connect();
	}
}
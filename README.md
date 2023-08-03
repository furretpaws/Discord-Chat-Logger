# Discord Chat Logger

A "Discord Chat Logger" is a program that forwards messages from a Discord Server to another, through a webhook. This is useful to make backups of the messages of a server, and save them in another server.
![Showcase](https://cdn.discordapp.com/attachments/1133545463346380941/1136603589314363422/image.png)__
What you are seeing here is basically the logged messages sent to a webhook

## How to use?
Just download the .exe file from the releases tab, run it and change everything it tells you.
The program will add 4 commands to your bot.
- `/reload` - Reloads the logger with new configuration
- `/set_target (id)` - Use this command to specify which server to log. The ID is the server ID
- `/set_token (token)` - Use this command to set the token of the account that will log messages. This has to be a normal user account. Keep in mind that this is considered as a self bot, and this is against Discord's TOS. Just use an alt account that you don't care about it being banned
- `/set_webhook (webhook)` - Use this command to set the webhook to send the messages. Look up for a tutorial on how to set one

## Building

To build this project, you will require the following things
- [Haxe](https://haxe.org)
- [Git](https://git-scm.com)
- [Visual Studio Community 2022 (OPTIONAL, ONLY FOR BUILDING THE EXE FILE)](https://visualstudio.microsoft.com/community)

Once you have those things installed, open up a terminal and type the following commands
```
haxelib git hxdiscord https://github.com/FurretDev/hxdiscord
haxelib git hxWebSockets https://github.com/ianharrigan/hxWebSockets
haxelib install tink_http
```

Close the terminal and open a new one inside the folder of this project, then, type this
```
haxe build.hxml
```
This will compile the project and it'll generate a new `main.n` file. To run it, just execute `neko main.n`.
To build an exe file, just edit the `build.hxml` file and change `--neko main.n` to `--cpp bin`. However, to compile to C++ (exe file), you will have to install some Visual Studio Community dependencies, so. Go to [Haxe C++ building instructions](https://haxe.org/manual/target-cpp-getting-started.html) for more information

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Contributors

- [@FurretDev](https://github.com/FurretDev) - Creator
- [@Crystallek](https://github.com/Crystallek) - Added SQL support

# Hubot: icinga-hubot-script

A hubot script that takes notification messages from Icinga and post them to any IRC channel.

See [`src/icinga-hubot-test.coffee`](src/icinga-hubot-test.coffee) for full documentation.

## Installation

Add **icinga-hubot-script** to your `package.json` file:

```json
"dependencies": {
  "hubot": ">= 2.5.1",
  "hubot-scripts": ">= 2.4.2",
  "icinga-hubot-script": ">= 0.0.0",
  "hubot-hipchat": "~2.5.1-5",
}
```

Add **icinga-hubot-script** to your `external-scripts.json`:

```json
["icinga-hubot-script"]
```

Run `npm install`

## Sample Interaction

```
user1>> hubot hello
hubot>> hello!
```

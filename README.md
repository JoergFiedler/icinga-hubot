# Hubot: icinga-hubot-script
[![Build Status](https://travis-ci.org/JoergFiedler/icinga-hubot.png?branch=master)](https://travis-ci.org/JoergFiedler/icinga-hubot)

A hubot script that takes notification messages from Icinga and post them to any IRC channel. You'll need
to install a plugin for Icinga as well. The plugin can be found [here](https://github.com/ImmobilienScout24/icinga-hubot-plugin).

See [`src/icinga-hubot.coffee`](src/icinga-hubot.coffee) for further documentation.

## Installation

Add **icinga-hubot-script** to your `package.json` file:

```json
"dependencies": {
  "hubot": ">= 2.5.1",
  "icinga-hubot-script": ">= 0.1.0",
}
```

Add **icinga-hubot-script** to your `external-scripts.json`:

```json
["icinga-hubot-script"]
```

Run `npm install`

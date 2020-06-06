# editbot

A bot that monitors edited posts for bad words.

### Why?

Reddit's automoderator can do a lot, but it will not act on any post that has been approved by a sub moderator. 

This bot exists to work around that. Specifically, it is mean to handle the case where an abusive user posts benign content with a new account, then a moderator approves the post (assuming the sub has restrictions on new or low karma users posting), after which the user edits their post to contain racist/hateful/doxxing/etc content. 

In this case automod will not apply any filters to the post because it has been approved by a mod. This bot, however, will monitor for edited posts and take action if a user edits their post to contain any trigger words.

### Setting up a Reddit API account

### Setting up the bot

### Configuration / options



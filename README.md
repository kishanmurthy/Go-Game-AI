# Go-Game-AI
An AI Agent created using MiniMax Algorithm for playing Go Game on 5 by 5 board


## About Go game

Go is an abstract strategy board game for two players in which the aim is to surround more territory than the opponent. The game was invented in China more than 2,500 years ago and is believed to be the oldest board game continuously played to the present day.
[More info](https://en.wikipedia.org/wiki/Go_(game))


### How to run the game

Calling run.sh will initiate the the game between MiniMax Agent and Random Agent. The Game Host (host.py) keeps track of the game process, gets the next moves from the players in turn, judges if the proposed moves are valid, wipes out the dead stones, and finally judges the winner.

### Game Rules and Winning Criteria

Player with the maximum points wins the game. The [Komi](https://en.wikipedia.org/wiki/Komi_(Go)) for the white player is set to 2.5 and no sucide moves are allowed.

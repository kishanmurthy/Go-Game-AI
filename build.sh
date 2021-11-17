#!/bin/bash
rm -rf *.so

cmd="python3 minimax_agent.py"
random_agent=("random_agent.py")

# play funcion
play()
{    
    echo Clean up... >&2
    if [ -f "input.txt" ]; then
        rm input.txt
    fi
    if [ -f "output.txt" ]; then
        rm output.txt
    fi
    cp init/input.txt ./input.txt

    echo Start Playing... >&2

	moves=0
	while true
	do
        if [ -f "output.txt" ]; then
	        rm output.txt
	    fi

        echo "Black makes move..." >&2
		eval "$1" >&2
		let moves+=1

		python3 host.py -m $moves -v True >&2
		rst=$?

		if [[ "$rst" != "0" ]]; then
			break
		fi

        if [ -f "output.txt" ]; then
	        rm output.txt
	    fi

		echo "White makes move..." >&2
		eval "$2" >&2
		let moves+=1

		python3 host.py -m $moves -v True >&2
		rst=$?

		if [[ "$rst" != "0" ]]; then
			break
		fi
	done

	echo $rst
}

play_time=2

### start playing ###

echo ""
echo $(date)

for i in {0..0}
do
    echo ""
    echo ==Playing with ${random_agent[i]}==
    echo $(date)
    random_agent_cmd="python3 ${random_agent[i]}"
    black_win_time=0
    white_win_time=0
    black_tie=0
    white_tie=0
    for (( round=1; round<=$play_time; round+=2 )) 
    do
        # Random Agent takes Black
        echo "=====Round $round====="
        echo Black:Random Agent White:MiniMax Agent 
        winner=$(play "$random_agent_cmd" "$cmd")
        if [[ "$winner" = "2" ]]; then
            echo 'White(MiniMax Agent) win!'
            let white_win_time+=1
        elif [[ "$winner" = "0" ]]; then
            echo Tie.
            let white_tie+=1
        else
            echo 'White(MiniMax Agent) lose.'
        fi

        # MiniMax agent takes Black
        echo "=====Round $((round+1))====="
        echo Black:MiniMax Agent White:Random Agent
        winner=$(play "$cmd" "$random_agent_cmd")
        if [[ "$winner" = "1" ]]; then
            echo 'Black(MiniMax Agent) win!'
            let black_win_time+=1
        elif [[ "$winner" = "0" ]]; then
            echo Tie.
            let black_tie+=1
        else
            echo 'Black(MiniMax Agent) lose.'
        fi
    done


    echo =====Summary=====  
    echo "MiniMax Agent play as Black Player | Win: $black_win_time | Lose: $((play_time/2-black_win_time-black_tie)) | Tie: $black_tie"
    echo "MiniMax Agent play as White Player | Win: $white_win_time | Lose: $((play_time/2-white_win_time-black_tie)) | Tie: $white_tie"
done

if [ -f "input.txt" ]; then
    rm input.txt
fi
if [ -f "output.txt" ]; then
    rm output.txt
fi
                                      
if [ -e "my_player.class" ]; then
    rm *.class
fi
if [ -e "exe" ]; then
    rm exe
fi
if [ -e "__pycache__" ]; then
    rm -rf __pycache__
fi
        
        
echo ""
echo Mission Completed.
echo $(date)
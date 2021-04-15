#include <a_samp>
#include <zcmd>

#define TEAM_COUNTER 0
#define TEAM_TERROR 1

#define CLASS_SELECTION_X -2476.7156
#define CLASS_SELECTION_Y 1544.5432
#define CLASS_SELECTION_Z 55.4610
#define CLASS_SELECTION_A 87.6057

#define WHITE_COLOUR 0xFFFFFFFF

#define HELP_DIALOG 0

enum player_data {
	player_team
};
new PlayerData[MAX_PLAYERS][player_data];

new Float:Random_Counter_Spawn[][4] =
{
    {-2303.3806, 1714.7681, 11.1563, 89.8459},//change
    {-2514.1428, 1780.7693, 11.2063, 359.1247}//change
};

new Float:Random_Terror_Spawn[][4] =
{
    {-2471.7043, 1538.5227, 33.2344, 0.4152},//change
    {-2366.7686, 1535.8488, 2.1172, 0.4275}//change
};

stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock Float:GetHealth(playerid)
{
    new Float:health;
	GetPlayerHealth(playerid, health);
	return health;
}

stock SetPlayerClass(playerid, classid)
{
	switch(classid)
	{
		case 0:
		{
		    PlayerData[playerid][player_team] = TEAM_COUNTER;
		    GameTextForPlayer(playerid, "~b~Counter Terrorist", 3000, 6);
        }
		case 1:
		{
		    PlayerData[playerid][player_team] = TEAM_COUNTER;
		    GameTextForPlayer(playerid, "~b~Counter Terrorist", 3000, 6);
        }
		case 2:
		{
		   	PlayerData[playerid][player_team] = TEAM_COUNTER;
		    GameTextForPlayer(playerid, "~b~Counter Terrorist", 3000, 6);
        }
		case 3:
		{
		    PlayerData[playerid][player_team] = TEAM_COUNTER;
		    GameTextForPlayer(playerid, "~b~Counter Terrorist", 3000, 6);
        }
		case 4:
		{
		    PlayerData[playerid][player_team] = TEAM_TERROR;
		    GameTextForPlayer(playerid, "~r~Terrorist", 3000, 6);
        }
		case 5:
		{
		    PlayerData[playerid][player_team] = TEAM_TERROR;
		    GameTextForPlayer(playerid, "~r~Terrorist", 3000, 6);
        }
		case 6:
		{
		    PlayerData[playerid][player_team] = TEAM_TERROR;
		    GameTextForPlayer(playerid, "~r~Terrorist", 3000, 6);
        }
		case 7:
		{
		    PlayerData[playerid][player_team] = TEAM_TERROR;
		    GameTextForPlayer(playerid, "~r~Terrorist", 3000, 6);
        }
	}
	return 1;
}

stock GetTeamCount(teamid)
{
     new player_count = 0;
     for(new i = 0; i < MAX_PLAYERS; i++)
     {
        if(IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
     		if(GetPlayerState(i) == PLAYER_STATE_NONE) continue;
           	if(PlayerData[i][player_team] != teamid) continue;
           	player_count++;
		}
     }
     return player_count;
}

main() { }

public OnGameModeInit()
{
	SetGameModeText("Team Death Match");
	
	//Counter Terrorist
	AddPlayerClass(287, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z, CLASS_SELECTION_A, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(286, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z, CLASS_SELECTION_A, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(285, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z, CLASS_SELECTION_A, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(179, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z, CLASS_SELECTION_A, 0, 0, 0, 0, 0, 0);
	
	//Terrorist
	AddPlayerClass(127, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z, CLASS_SELECTION_A, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(125, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z, CLASS_SELECTION_A, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(124, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z, CLASS_SELECTION_A, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(122, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z, CLASS_SELECTION_A, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);

	SetPlayerClass(playerid, classid);
	
    SetPlayerPos(playerid, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z);
    SetPlayerFacingAngle(playerid, CLASS_SELECTION_A);
    SetPlayerCameraLookAt(playerid, CLASS_SELECTION_X, CLASS_SELECTION_Y, CLASS_SELECTION_Z);
    SetPlayerCameraPos(playerid, CLASS_SELECTION_X + (5 * floatsin(-CLASS_SELECTION_A, degrees)), CLASS_SELECTION_Y + (5 * floatcos(-CLASS_SELECTION_A, degrees)), CLASS_SELECTION_Z);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	new CounterCount = GetTeamCount(TEAM_COUNTER);
 	new TerrorCount = GetTeamCount(TEAM_TERROR);
 	
	if(PlayerData[playerid][player_team] == TEAM_COUNTER)
	{
	    if(CounterCount > TerrorCount)
	    {
	        SendClientMessage(playerid, WHITE_COLOUR, "ERROR: Team MAXED OUT. Please choose Terrorist class.");
	 		return 0;
	    }
	}
	else if(PlayerData[playerid][player_team] == TEAM_TERROR)
	{
	    if(TerrorCount > CounterCount)
	    {
	        SendClientMessage(playerid, WHITE_COLOUR, "ERROR: Team MAXED OUT. Please choose Counter-Terrorist class.");
	     	return 0;
	    }
	}
    return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[128];
    if(text[0] == '@')//Team Radio
    {
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i) && !IsPlayerNPC(i))
            {
                if(PlayerData[i][player_team] == PlayerData[playerid][player_team])
                {
        			strdel(text, 0, 1);
                    format(string, sizeof(string), "@ %s: %s", GetName(playerid), text);
                    SendClientMessage(i, WHITE_COLOUR, string);
                }
            }
        }
        return 0;
    }
	return 1;
}

public OnPlayerConnect(playerid)
{
	new string[128];
	format(string, sizeof(string), "PART: %s [%d] has joined the server!", GetName(playerid), playerid);
	
	SendClientMessageToAll(WHITE_COLOUR, string);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new string[128];
	format(string, sizeof(string), "PART: %s [%d] has left the server!", GetName(playerid), playerid);

	SendClientMessageToAll(WHITE_COLOUR, string);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(PlayerData[playerid][player_team] == TEAM_COUNTER)
	{
	    SetPlayerTeam(playerid, TEAM_COUNTER);
	    new position = random(sizeof(Random_Counter_Spawn));
		SetPlayerPos(playerid, Random_Counter_Spawn[position][0], Random_Counter_Spawn[position][1], Random_Counter_Spawn[position][2]);
	}
	else if(PlayerData[playerid][player_team] == TEAM_TERROR)
	{
	    SetPlayerTeam(playerid, TEAM_TERROR);
	    new position = random(sizeof(Random_Terror_Spawn));
		SetPlayerPos(playerid, Random_Terror_Spawn[position][0], Random_Terror_Spawn[position][1], Random_Terror_Spawn[position][2]);
	}
	
	SetPlayerHealth(playerid, 100.0);
	SetPlayerArmour(playerid, 0.0);
	
	GivePlayerWeapon(playerid, 22, 250); //9mm
	GivePlayerWeapon(playerid, 29, 500); //MP5
	GivePlayerWeapon(playerid, 30, 500); //AK47
	GivePlayerWeapon(playerid, 33, 500); //Country Rifle
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(PlayerData[killerid][player_team] == TEAM_COUNTER && PlayerData[playerid][player_team] == TEAM_COUNTER || PlayerData[killerid][player_team] == TEAM_TERROR && PlayerData[playerid][player_team] == TEAM_TERROR)
	{
	    SendClientMessage(playerid, WHITE_COLOUR, "SERVER: DO NOT kill your team members!");
		return 1;
	}

	SetPlayerScore(playerid, GetPlayerScore(playerid) - 1);
	SetPlayerScore(killerid, GetPlayerScore(killerid) + 1);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == HELP_DIALOG)
	{
	    if(!response)
	    {
	        //SaveAccount();
	    }
	}
	return 1;
}

CMD:help(playerid, params[])
{
	if(PlayerData[playerid][player_team] == TEAM_COUNTER)
	{
		ShowPlayerDialog(playerid, HELP_DIALOG, DIALOG_STYLE_MSGBOX, "You are a Counter Terrorist", "Your job is to take out the Terrorists!", "Close", "Save");
	}
	else if(PlayerData[playerid][player_team] == TEAM_TERROR)
	{
		ShowPlayerDialog(playerid, HELP_DIALOG, DIALOG_STYLE_MSGBOX, "You are a Terrorist", "Your job is to take out the Counter Terrorists!", "Close", "Save");
	}
	return 1;
}

CMD:healme(playerid, params[])
{
	SetPlayerHealth(playerid, 100);
	
	SendClientMessage(playerid, WHITE_COLOUR, "SERVER: You have been healed.");
	return 1;
}


#include <a_samp>

#define WHITE_COLOUR 0xFFFFFFFF

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

main() { }

public OnGameModeInit()
{
	SetGameModeText("Team Death Match");
	
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(1, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(2, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(3, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(4, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(5, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, -1849.2897, -1708.3475, 46.2188);
	SetPlayerFacingAngle(playerid, 83.4979);
	SetPlayerCameraLookAt(playerid,  -1849.2897, -1708.3475, 46.2188);
	SetPlayerCameraPos(playerid, -1849.2897 + (5 * floatsin(-83.4979, degrees)), -1708.3475 + (5 * floatcos(-83.4979, degrees)), 46.2188);
	return 1;
}

public OnPlayerText(playerid, text[])
{
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
	SetPlayerPos(playerid, 0.0, 0.0, 0.0);
	SetPlayerFacingAngle(playerid, 0.0);
	
	SetPlayerHealth(playerid, 50.0);
	
	GivePlayerWeapon(playerid, 24, 500);
	
	SendClientMessage(playerid, WHITE_COLOUR, "SERVER: Here, have a deagle with 500 ammo!");
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SetPlayerScore(playerid, GetPlayerScore(playerid) - 1);
	SetPlayerScore(killerid, GetPlayerScore(killerid) + 1);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/deagle", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid, 24, 500);
		return 1;
	}

	if (strcmp("/shotgun", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid, 26, 500);
		return 1;
	}

	if (strcmp("/heli", cmdtext, true, 10) == 0)
	{
	    new Float:pos[3];
	    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		CreateVehicle(469, pos[0], pos[1], pos[2], 0.0, WHITE_COLOUR, WHITE_COLOUR, -1);
		return 1;
	}

	if (strcmp("/healme", cmdtext, true, 10) == 0)
	{
		if(GetHealth(playerid) >= 100.0)
		{
            SendClientMessage(playerid, WHITE_COLOUR, "ERROR: You already have 100 HP!");
            return 1;
		}
		
		SetPlayerHealth(playerid, 100.0);
		
		SendClientMessage(playerid, WHITE_COLOUR, "SERVER: You have been healed!");
		return 1;
	}
	return 0;
}


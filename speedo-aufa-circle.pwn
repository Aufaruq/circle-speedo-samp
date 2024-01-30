#include <YSI_Coding\y_hooks>
#include <cprogress>
//rumus
/*
160.000244, 375.259460
160.000244, 375.259
//244
//460
24.500
16.000
184.500244, 391.259460
rumus
244
460
24.500
16.000
*/
// BY AUFAAAAAAAAA
new use_speedo[MAX_PLAYERS];
new speedo_timer;
new Text:speedoball;
new PlayerText:speedo[MAX_PLAYERS][7] = { PlayerText:0xFFFF,... };

new Float:VEHICLE_TOP_SPEEDS[] =
{
	157.0, 147.0, 186.0, 110.0, 133.0, 164.0, 110.0, 148.0, 100.0, 158.0, 129.0, 221.0, 168.0, 110.0, 105.0, 192.0, 154.0, 270.0, 115.0, 149.0,
	145.0, 154.0, 140.0, 99.0,  135.0, 270.0, 173.0, 165.0, 157.0, 201.0, 190.0, 130.0, 94.0,  110.0, 167.0, 0.0,   149.0, 158.0, 142.0, 168.0,
	136.0, 145.0, 139.0, 126.0, 110.0, 164.0, 270.0, 270.0, 111.0, 0.0,   0.0,   193.0, 270.0, 60.0,  135.0, 157.0, 106.0, 95.0,  157.0, 136.0,
	270.0, 160.0, 111.0, 142.0, 145.0, 145.0, 147.0, 140.0, 144.0, 270.0, 157.0, 110.0, 190.0, 190.0, 149.0, 173.0, 270.0, 186.0, 117.0, 140.0,
	184.0, 73.0,  156.0, 122.0, 190.0, 99.0,  64.0,  270.0, 270.0, 139.0, 157.0, 149.0, 140.0, 270.0, 214.0, 176.0, 162.0, 270.0, 108.0, 123.0,
	140.0, 145.0, 216.0, 216.0, 173.0, 140.0, 179.0, 166.0, 108.0, 79.0,  101.0, 270.0,	270.0, 270.0, 120.0, 142.0, 157.0, 157.0, 164.0, 270.0,
	270.0, 160.0, 176.0, 151.0, 130.0, 160.0, 158.0, 149.0, 176.0, 149.0, 60.0,  70.0,  110.0, 167.0, 168.0, 158.0, 173.0, 0.0,   0.0,   270.0,
	149.0, 203.0, 164.0, 151.0, 150.0, 147.0, 149.0, 142.0, 270.0, 153.0, 145.0, 157.0, 121.0, 270.0, 144.0, 158.0, 113.0, 113.0, 156.0, 178.0,
	169.0, 154.0, 178.0, 270.0, 145.0, 165.0, 160.0, 173.0, 146.0, 0.0,   0.0,   93.0,  60.0,  110.0, 60.0,  158.0, 158.0, 270.0, 130.0, 158.0,
	153.0, 151.0, 136.0, 85.0,  0.0,   153.0, 142.0, 165.0, 108.0, 162.0, 0.0,   0.0,   270.0, 270.0, 130.0, 190.0, 175.0, 175.0, 175.0, 158.0,
	151.0, 110.0, 169.0, 171.0, 148.0, 152.0, 0.0,   0.0,   0.0,   108.0, 0.0,   0.0
};

hook OnGameModeInit() { 
    speedoball = TextDrawCreate(160.000244, 375.259460, "LD_POOL:ball");
    TextDrawTextSize(speedoball, 48.000000, 54.000000);
    TextDrawAlignment(speedoball, 1);
    TextDrawColor(speedoball, -181);
    TextDrawSetShadow(speedoball, 0);
    TextDrawSetOutline(speedoball, 0);
    TextDrawBackgroundColor(speedoball, 255);
    TextDrawFont(speedoball, 4);
    TextDrawSetProportional(speedoball, 0);
	speedo_timer = SetTimer("speedoupdate", 250, 1);
	for (new playerid = GetPlayerPoolSize(); playerid > -1; playerid--)
	{
		if (!IsPlayerConnected(playerid) || IsPlayerNPC(playerid)) continue;
		speedo[playerid][0] = CreatePlayerTextDraw(playerid, 182.132, 383.265, "0");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][0], 0.428, 1.746);
		PlayerTextDrawAlignment(playerid, speedo[playerid][0], 2);
		PlayerTextDrawColor(playerid, speedo[playerid][0], 255);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][0], 255);
		PlayerTextDrawFont(playerid, speedo[playerid][0], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][0], 1);

		speedo[playerid][1] = CreatePlayerTextDraw(playerid, 169.000, 398.000, "Km/H");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][1], 0.300, 1.500);
		PlayerTextDrawAlignment(playerid, speedo[playerid][1], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][1], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][1], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][1], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][1], 255);
		PlayerTextDrawFont(playerid, speedo[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][1], 1);

		speedo[playerid][2] = CreatePlayerTextDraw(playerid, 175.000, 362.000, "20:20");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][2], 0.180, 1.098);
		PlayerTextDrawAlignment(playerid, speedo[playerid][2], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][2], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][2], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][2], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][2], 150);
		PlayerTextDrawFont(playerid, speedo[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][2], 1);

		speedo[playerid][3] = CreatePlayerTextDraw(playerid, 207.000, 361.259, "LD_POOL:ball");
		PlayerTextDrawTextSize(playerid, speedo[playerid][3], 32.000, 36.000);
		PlayerTextDrawAlignment(playerid, speedo[playerid][3], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][3], -181);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][3], 255);
		PlayerTextDrawFont(playerid, speedo[playerid][3], 4);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][3], 0);

		speedo[playerid][4] = CreatePlayerTextDraw(playerid, 215.000, 367.000, "Fuel");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][4], 0.180, 1.098);
		PlayerTextDrawAlignment(playerid, speedo[playerid][4], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][4], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][4], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][4], 150);
		PlayerTextDrawFont(playerid, speedo[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][4], 1);

		speedo[playerid][5] = CreatePlayerTextDraw(playerid, 213.000, 376.000, "100");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][5], 0.259, 1.299);
		PlayerTextDrawAlignment(playerid, speedo[playerid][5], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][5], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][5], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][5], 150);
		PlayerTextDrawFont(playerid, speedo[playerid][5], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][5], 1);

		speedo[playerid][6] = CreatePlayerTextDraw(playerid, 213.000, 403.000, "Barat Daya");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][6], 0.200, 1.599);
		PlayerTextDrawAlignment(playerid, speedo[playerid][6], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][6], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][6], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][6], 150);
		PlayerTextDrawFont(playerid, speedo[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][6], 1);

	}
	return 1;
}

hook OnGameModeExit() {
    TextDrawDestroy(speedoball);
	KillTimer(speedo_timer);
	for (new playerid = 0; playerid < MAX_PLAYERS; playerid++)
	{
		if (!IsPlayerConnected(playerid) || IsPlayerNPC(playerid)) continue;
		PlayerTextDrawDestroy(playerid, speedo[playerid][0]);
        PlayerTextDrawDestroy(playerid, speedo[playerid][1]);
		PlayerTextDrawDestroy(playerid, speedo[playerid][2]);
		PlayerTextDrawDestroy(playerid, speedo[playerid][3]);
		PlayerTextDrawDestroy(playerid, speedo[playerid][4]);
		PlayerTextDrawDestroy(playerid, speedo[playerid][5]);
		PlayerTextDrawDestroy(playerid, speedo[playerid][6]);
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	if (!IsPlayerNPC(playerid))
	{
		speedo[playerid][0] = CreatePlayerTextDraw(playerid, 182.132, 383.265, "0");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][0], 0.428, 1.746);
		PlayerTextDrawAlignment(playerid, speedo[playerid][0], 2);
		PlayerTextDrawColor(playerid, speedo[playerid][0], 255);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][0], 255);
		PlayerTextDrawFont(playerid, speedo[playerid][0], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][0], 1);

		speedo[playerid][1] = CreatePlayerTextDraw(playerid, 169.000, 398.000, "Km/H");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][1], 0.300, 1.500);
		PlayerTextDrawAlignment(playerid, speedo[playerid][1], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][1], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][1], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][1], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][1], 255);
		PlayerTextDrawFont(playerid, speedo[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][1], 1);

		speedo[playerid][2] = CreatePlayerTextDraw(playerid, 175.000, 362.000, "20:20");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][2], 0.180, 1.098);
		PlayerTextDrawAlignment(playerid, speedo[playerid][2], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][2], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][2], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][2], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][2], 150);
		PlayerTextDrawFont(playerid, speedo[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][2], 1);

		speedo[playerid][3] = CreatePlayerTextDraw(playerid, 207.000, 361.259, "LD_POOL:ball");
		PlayerTextDrawTextSize(playerid, speedo[playerid][3], 32.000, 36.000);
		PlayerTextDrawAlignment(playerid, speedo[playerid][3], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][3], -181);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][3], 255);
		PlayerTextDrawFont(playerid, speedo[playerid][3], 4);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][3], 0);

		speedo[playerid][4] = CreatePlayerTextDraw(playerid, 215.000, 367.000, "Fuel");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][4], 0.180, 1.098);
		PlayerTextDrawAlignment(playerid, speedo[playerid][4], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][4], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][4], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][4], 150);
		PlayerTextDrawFont(playerid, speedo[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][4], 1);

		speedo[playerid][5] = CreatePlayerTextDraw(playerid, 213.000, 376.000, "100");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][5], 0.259, 1.299);
		PlayerTextDrawAlignment(playerid, speedo[playerid][5], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][5], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][5], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][5], 150);
		PlayerTextDrawFont(playerid, speedo[playerid][5], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][5], 1);

		speedo[playerid][6] = CreatePlayerTextDraw(playerid, 213.000, 403.000, "Barat Daya");
		PlayerTextDrawLetterSize(playerid, speedo[playerid][6], 0.200, 1.599);
		PlayerTextDrawAlignment(playerid, speedo[playerid][6], 1);
		PlayerTextDrawColor(playerid, speedo[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, speedo[playerid][6], 1);
		PlayerTextDrawSetOutline(playerid, speedo[playerid][6], 1);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid][6], 150);
		PlayerTextDrawFont(playerid, speedo[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid][6], 1);
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	PlayerTextDrawDestroy(playerid, speedo[playerid][0]);
	PlayerTextDrawDestroy(playerid, speedo[playerid][1]);
	PlayerTextDrawDestroy(playerid, speedo[playerid][2]);
	PlayerTextDrawDestroy(playerid, speedo[playerid][3]);
	PlayerTextDrawDestroy(playerid, speedo[playerid][4]);
	PlayerTextDrawDestroy(playerid, speedo[playerid][5]);
	PlayerTextDrawDestroy(playerid, speedo[playerid][6]);
    speedo[playerid][0] = PlayerText:0xFFFF;
	speedo[playerid][1] = PlayerText:0xFFFF;
	speedo[playerid][2] = PlayerText:0xFFFF;
	speedo[playerid][3] = PlayerText:0xFFFF;
	speedo[playerid][4] = PlayerText:0xFFFF;
	speedo[playerid][5] = PlayerText:0xFFFF;
	speedo[playerid][6] = PlayerText:0xFFFF;
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(use_speedo[playerid])
	{
		if(newstate == 2 && oldstate != 2)
		{
		    TextDrawShowForPlayer(playerid, speedoball);
			PlayerTextDrawShow(playerid, speedo[playerid][0]);
            PlayerTextDrawShow(playerid, speedo[playerid][1]);
			PlayerTextDrawShow(playerid, speedo[playerid][2]);
			PlayerTextDrawShow(playerid, speedo[playerid][3]);
			PlayerTextDrawShow(playerid, speedo[playerid][4]);
			PlayerTextDrawShow(playerid, speedo[playerid][5]);
			PlayerTextDrawShow(playerid, speedo[playerid][6]);
		}
		if(newstate != 2 && oldstate == 2)
		{
	        TextDrawHideForPlayer(playerid, speedoball);
			PlayerTextDrawHide(playerid, speedo[playerid][0]);
            PlayerTextDrawHide(playerid, speedo[playerid][1]);
			PlayerTextDrawHide(playerid, speedo[playerid][2]);
			PlayerTextDrawHide(playerid, speedo[playerid][3]);
			PlayerTextDrawHide(playerid, speedo[playerid][4]);
			PlayerTextDrawHide(playerid, speedo[playerid][5]);
			PlayerTextDrawHide(playerid, speedo[playerid][6]);
			DestroyPlayerCircleProgressSpeedo(playerid);
		}
	return 1;
	}
}

//compas
new textcompass[4][MAX_PLAYERS];

stock GetPlayerHeading(playerid)
{
	new Float:rz, Float:yx, Float:yy, Float:yz;
	new p_PreviousCompass[4], compass[128];

	strcat((p_PreviousCompass[0] = EOS, p_PreviousCompass), textcompass[playerid]);

	if(IsPlayerInAnyVehicle(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), rz);
	}
	else 
	{
		GetPlayerFacingAngle(playerid, rz);
	}

	if(rz >= 348.75 || rz < 11.25) textcompass[playerid] = "Utara";
	else if(rz >= 258.75 && rz < 281.25) textcompass[playerid] = "Timur";
	else if(rz >= 210.0 && rz < 249.0) textcompass[playerid] = "Tenggara";
	else if(rz >= 168.75 && rz < 191.25) textcompass[playerid] = "Selatan";
	else if(rz >= 110.0 && rz < 159.0)  textcompass[playerid] = "Barat Daya";
	else if(rz >= 78.75 && rz < 101.25) textcompass[playerid] = "Barat";
	else if(rz >= 20 && rz < 69.0) textcompass[playerid] = "Laut Barat";
	else if(rz >= 291.0 && rz < 339) textcompass[playerid] = "Timur Laut";

    GetPlayerPos(playerid, yx, yy, yz);
    format(compass, sizeof(compass), "%s l %s", textcompass[playerid],GetLocation(yx, yy, yz));
	PlayerTextDrawSetString(playerid, speedo[playerid][6], compass);
    PlayerTextDrawShow(playerid, speedo[playerid][6]);
	return 1;
}

CMD:speedo(playerid, params[])
{
	if (!use_speedo[playerid])
	{
		SendClientMessage(playerid, -1, "Speedometer: {00FA00}ON");
		use_speedo[playerid] = 1;
		if (GetPlayerState(playerid) != 2) return 1;
		TextDrawShowForPlayer(playerid, speedoball);
		PlayerTextDrawShow(playerid, speedo[playerid][0]);
        PlayerTextDrawShow(playerid, speedo[playerid][1]);
		PlayerTextDrawShow(playerid, speedo[playerid][2]);
		PlayerTextDrawShow(playerid, speedo[playerid][3]);
		PlayerTextDrawShow(playerid, speedo[playerid][4]);
		PlayerTextDrawShow(playerid, speedo[playerid][5]);
		PlayerTextDrawShow(playerid, speedo[playerid][6]);
		return 1;
	}
	SendClientMessage(playerid, -1, "Speedometer: {FA0000}OFF");
	use_speedo[playerid] = 0;
	TextDrawHideForPlayer(playerid, speedoball);
    PlayerTextDrawHide(playerid, speedo[playerid][0]);
	PlayerTextDrawHide(playerid, speedo[playerid][1]);
	PlayerTextDrawHide(playerid, speedo[playerid][2]);
	PlayerTextDrawHide(playerid, speedo[playerid][3]);
	PlayerTextDrawHide(playerid, speedo[playerid][4]);
	PlayerTextDrawHide(playerid, speedo[playerid][5]);
	PlayerTextDrawHide(playerid, speedo[playerid][6]);
	DestroyPlayerCircleProgressSpeedo(playerid);
	return 1;
}

forward speedoupdate();

public speedoupdate()
{
	new string[4], veh, Float:speed, Float:x, Float:y, Float:z, model;
	for (new playerid = GetPlayerPoolSize(); playerid > -1; playerid--)
	{
		if (!use_speedo[playerid] || GetPlayerState(playerid) != 2) continue;
		veh = GetPlayerVehicleID(playerid);
		model = GetVehicleModel(veh);
		GetVehicleVelocity(veh, x, y, z);
		speed = floatmul(floatsqroot(floatadd(floatmul(x, x), floatmul(y, y))), 180.0);
		format(string, 4, "%.0f", speed);
		PlayerTextDrawSetString(playerid, speedo[playerid][0], string);
		ShowPlayerCircleProgress(playerid, floatround(speed / VEHICLE_TOP_SPEEDS[model - 400] * 100.0), 184.500244, 391.259460, 0xAA00FFFF);
	}
	return 1;
}
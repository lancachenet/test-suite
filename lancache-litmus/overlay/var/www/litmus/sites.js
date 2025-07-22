var cachedomains = {
	"arenanet": {
		"description": "CDN for guild wars, HoT",
		"domains": [
			"assetcdn.101.arenanetworks.com",
			"assetcdn.102.arenanetworks.com",
			"assetcdn.103.arenanetworks.com",
		]
	},
	"blizzard": {
		"description": "CDN for blizzard/battle.net",
		"domains": [
			"dist.blizzard.com",
			"dist.blizzard.com.edgesuite.net",
			"blizzard.vo.llnwd.net",
			"blzddist1-a.akamaihd.net",
			"blzddist2-a.akamaihd.net",
			"blzddist3-a.akamaihd.net",
			"level3.blizzard.com",
			"nydus.battle.net",
			"edge.blizzard.top.comcast.net",
			"cdn.blizzard.com",
		]
	},
	"bsg": {
		"description": "CDN for Battle State Games, Tarkov",
		"domains": [
			"cdn-11.eft-store.com",
			"cl-453343cd.gcdn.co",
		]
	},
	"cityofheroes": {
		"description": "CDN for City of Heroes (Homecoming)",
		"domains": [
			"cdn-na1.homecomingservers.com",
			"cdn-na2.homecomingservers.com",
			"cdn-na3.homecomingservers.com",
			"cdn-eu1.homecomingservers.com",
		]
	},
	"callofduty": {
		"description": "CDN for Call of duty games",
		"domains": [
			"cod-assets.cdn.callofduty.com",
			"cod-assets.cdn.callofduty.com.edgesuite.net",
		]
	},
	"daybreak": {
		"description": "Daybreak games CDN",
		"domains": [
			"pls.patch.daybreakgames.com",
		]
	},
	"epicgames": {
		"description": "CDN for Epic Games",
		"domains": [
			"cdn1.epicgames.com",
			"cdn2.epicgames.com",
			"cdn.unrealengine.com",
			"cdn1.unrealengine.com",
			"cdn2.unrealengine.com",
			"cdn3.unrealengine.com",
			"download.epicgames.com",
			"download2.epicgames.com",
			"download3.epicgames.com",
			"download4.epicgames.com",
			"epicgames-download1.akamaized.net",
			"fastly-download.epicgames.com",
			"cloudflare.epicgamescdn.com",
			"egdownload.fastly-edge.com"
		]
	},
	"frontier": {
		"description": "CDN for frontier games",
		"domains": [
			"cdn.zaonce.net",
		]
	},
	"neverwinter": {
		"description": "Cryptic CDN for Neverwinter",
		"domains": [
			"level3.nwhttppatch.crypticstudios.com",
		]
	},
	"nexusmods": {
		"description": "Nexus mods / skyrim content",
		"domains": [
			"filedelivery.nexusmods.com",
		]
	},
	"nintendo": {
		"description": "CDN for Nintendo consoles and download servers",
		"domains": [
			"ccs.cdn.wup.shop.nintendo.net",
			"ccs.cdn.wup.shop.nintendo.net.edgesuite.net",
			"geisha-wup.cdn.nintendo.net",
			"geisha-wup.cdn.nintendo.net.edgekey.net",
			"idbe-wup.cdn.nintendo.net",
			"idbe-wup.cdn.nintendo.net.edgekey.net",
			"ecs-lp1.hac.shop.nintendo.net",
			"receive-lp1.dg.srv.nintendo.net",
		]
	},
	"origin": {
		"description": "CDN for origin",
		"domains": [
			"origin-a.akamaihd.net",
			"lvlt.cdn.ea.com",
			"cdn-patch.swtor.com",
		]
	},
	"pathofexile": {
		"description": "CDN for pathofexile",
		"domains": [
			"patchcdn.pathofexile.com",
		]
	},

	"renegadex": {
		"description": "CDN for Renegadex",
		"domains": [
			"patches.totemarts.services",
			"patches.totemarts.games",
		]
	},
	"riot": {
		"description": "CDN for riot games",
		"domains": [
			"l3cdn.riotgames.com",
			"worldwide.l3cdn.riotgames.com",
			"riotgamespatcher-a.akamaihd.net",
			"riotgamespatcher-a.akamaihd.net.edgesuite.net",
		]
	},
	"rockstar": {
		"description": "CDN for rockstar games",
		"domains": [
			"patches.rockstargames.com",
		]
	},
	"sony": {
		"description": "CDN for Sony / PlayStation downloads and services",
		"domains": [
			"gs2.ww.prod.dl.playstation.net",
			"gs2-ww-prod.psn.akadns.net",
			"gs2.ww.prod.dl.playstation.net.edgesuite.net",
			"playstation4.sony.akadns.net",
			"theia.dl.playstation.net",
			"tmdb.np.dl.playstation.net",
			"gs-sec.ww.np.dl.playstation.net",
			"uef.np.dl.playstation.net",
			"gst.prod.dl.playstation.net",
			"vulcan.dl.playstation.net",
			"sgst.prod.dl.playstation.net",
			"psnobj.prod.dl.playstation.net",
		]
	},
	"square": {
		"description": "CDN for square",
		"domains": [
			"patch-dl.ffxiv.com",
		]
	},

	"steam": {
		"description": "CDN for steam platform",
		"domains": [
			"lancache.steamcontent.com",
		]
	},
	"teso": {
		"description": "CDN for The Elder Scrolls Online",
		"domains": [
			"live.patcher.elderscrollsonline.com",
		]
	},
	"uplay": {
		"description": "CDN for uplay downloader",
		"domains": [
			"*.cdn.ubi.com",
		]
	},
	"warframe": {
		"description": "CDN for Warframe",
		"domains": [
			"content.warframe.com",
		]
	},
	"wargaming": {
		"description": "CDN for wargaming.net",
		"domains": [
			"dl2.wargaming.net",
			"wg.gcdn.co",
			"wgus-wotasia.wargaming.net",
			"dl-wot-ak.wargaming.net",
			"dl-wot-gc.wargaming.net",
			"dl-wot-se.wargaming.net",
			"dl-wot-cdx.wargaming.net",
			"dl-wows-ak.wargaming.net",
			"dl-wows-gc.wargaming.net",
			"dl-wows-se.wargaming.net",
			"dl-wows-cdx.wargaming.net",
			"dl-wowp-ak.wargaming.net",
			"dl-wowp-gc.wargaming.net",
			"dl-wowp-se.wargaming.net",
			"dl-wowp-cdx.wargaming.net",
			"wgus-woteu.wargaming.net",
		]
	},
	"windowsupdates": {
		"description": "CDN for Microsoft Windows Services",
		"domains": [
			"dl.delivery.mp.microsoft.com",
			"amupdatedl.microsoft.com",
			"amupdatedl2.microsoft.com",
			"amupdatedl3.microsoft.com",
			"amupdatedl4.microsoft.com",
			"amupdatedl5.microsoft.com",
			"officecdn.microsoft.com",
			"officecdn.microsoft.com.edgesuite.net",
		]
	},
	"xboxlive": {
		"description": "CDN for xboxlive",
		"domains": [
			"assets1.xboxlive.com",
			"assets2.xboxlive.com",
			"xbox-mbr.xboxlive.com",
			"assets1.xboxlive.com.nsatc.net",
			"xvcf1.xboxlive.com",
			"xvcf2.xboxlive.com",
			"d1.xboxlive.com",
		]
	},
};
var urltext='';
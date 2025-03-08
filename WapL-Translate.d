#!/usr/bin/env dub
/+ dub.sdl:
    name "wapl-translate"
    targetName "trans.cgi"
    description "WapL Translate: A DeepL Translate powered translator for the WAP."
    authors "StoryDragon"
    copyright "Copyright © 2025, StoryDragon"
    license "BSD-3-Clause"
    dependency "requests" version="~>2.1.3"
+/

void main() {
	//import std.net.curl;
	import std.stdio: write;
	import std.process: environment;
	import std.string;
	//import std.uni;
	import std.json;
	import std.algorithm.searching: canFind;
	import std.uri: decode;
	//import std.conv: to;
	import requests;
	auto DIEPSLEUTEL = "REDACTED!!!"; //I will not publish my DeepL api secret code...
	auto vraag = environment.get("QUERY_STRING");
	auto slangs = [ "AUTO", "AR", "BG", "CS", "DA", "DE", "EL", "EN", "ES", "ET", "FI", "FR", "HU", "ID", "IT", "JA", "KO", "LT", "LV", "NB", "NL", "PL", "PT", "RO", "RU", "SK", "SL", "SV", "TR", "UK", "ZH" ];
	auto elangs = [ "AR", "BG", "CS", "DA", "DE", "EL", "EN", "EN-GB", "EN-US", "ES", "ET", "FI", "FR", "HU", "ID", "IT", "JA", "KO", "LT", "LV", "NB", "NL", "PL", "PT", "PT-BR", "PT-PT", "RO", "RU", "SK", "SL", "SV", "TR", "UK", "ZH", "ZH-HANS", "ZH-HANT" ];
	//I hoped that this would work, but it did not... :(
	//auto ISO_8859_5 = [
		/*cast(ubyte[])[208, 129]: cast(ubyte[])[194, 161], cast(ubyte[])[208, 130]: cast(ubyte[])[194, 162], cast(ubyte[])[208, 131]: cast(ubyte[])[194, 163], cast(ubyte[])[208, 132]: cast(ubyte[])[226, 130],
		cast(ubyte[])[208, 133]: "&#xa5;", cast(ubyte[])[208, 134]: "&#xa6;", cast(ubyte[])[208, 135]: "&#xa7;", cast(ubyte[])[208, 136]: "&#xa8;",
		cast(ubyte[])[208, 137]: "&#xa9;", cast(ubyte[])[208, 138]: "&#xaa;", cast(ubyte[])[208, 139]: "&#xab;", cast(ubyte[])[208, 140]: "&#xac;",
		cast(ubyte[])[208, 142]: "&#xae;", cast(ubyte[])[208, 143]: "&#xaf;", cast(ubyte[])[208, 144]: "&#xb0;", cast(ubyte[])[208, 145]: "&#xb1;",
		cast(ubyte[])[208, 146]: "&#xb2;", cast(ubyte[])[208, 147]: "&#xb3;", cast(ubyte[])[208, 148]: "&#xb4;", cast(ubyte[])[208, 149]: "&#xb5;",
		cast(ubyte[])[208, 150]: "&#xb6;", cast(ubyte[])[208, 151]: "&#xb7;", cast(ubyte[])[208, 152]: "&#xb8;", cast(ubyte[])[208, 153]: "&#xb9;",
		cast(ubyte[])[208, 154]: "&#xba;", cast(ubyte[])[208, 155]: "&#xbb;", cast(ubyte[])[208, 156]: "&#xbc;", cast(ubyte[])[208, 157]: "&#xbd;",
		cast(ubyte[])[208, 158]: "&#xbe;", cast(ubyte[])[208, 159]: "&#xbf;", cast(ubyte[])[208, 160]: "&#xc0;", cast(ubyte[])[208, 161]: "&#xc1;",
		cast(ubyte[])[208, 162]: "&#xc2;", cast(ubyte[])[208, 163]: "&#xc3;", cast(ubyte[])[208, 164]: "&#xc4;", cast(ubyte[])[208, 165]: "&#xc5;",
		cast(ubyte[])[208, 166]: "&#xc6;", cast(ubyte[])[208, 167]: "&#xc7;", cast(ubyte[])[208, 168]: "&#xc8;", cast(ubyte[])[208, 169]: "&#xc9;",
		cast(ubyte[])[208, 170]: "&#xca;", cast(ubyte[])[208, 171]: "&#xcb;", cast(ubyte[])[208, 172]: "&#xcc;", cast(ubyte[])[208, 173]: "&#xcd;",
		cast(ubyte[])[208, 174]: "&#xce;", cast(ubyte[])[208, 175]: "&#xcf;", cast(ubyte[])[208, 176]: "&#xd0;", cast(ubyte[])[208, 177]: "&#xd1;",
		cast(ubyte[])[208, 178]: "&#xd2;", cast(ubyte[])[208, 179]: "&#xd3;", cast(ubyte[])[208, 180]: "&#xd4;", cast(ubyte[])[208, 181]: "&#xd5;",
		cast(ubyte[])[208, 182]: "&#xd6;", cast(ubyte[])[208, 183]: "&#xd7;", cast(ubyte[])[208, 184]: "&#xd8;", cast(ubyte[])[208, 185]: "&#xd9;",
		cast(ubyte[])[208, 186]: "&#xda;", cast(ubyte[])[208, 187]: "&#xdb;", cast(ubyte[])[208, 188]: "&#xdc;", cast(ubyte[])[208, 189]: "&#xdd;",
		cast(ubyte[])[208, 190]: "&#xde;", cast(ubyte[])[208, 191]: "&#xdf;", cast(ubyte[])[209, 128]: "&#xe0;", cast(ubyte[])[209, 129]: "&#xe1;",
		cast(ubyte[])[209, 130]: "&#xe2;", cast(ubyte[])[209, 131]: "&#xe3;", cast(ubyte[])[209, 132]: "&#xe4;", cast(ubyte[])[209, 133]: "&#xe5;",
		cast(ubyte[])[209, 134]: "&#xe6;", cast(ubyte[])[209, 135]: "&#xe7;", cast(ubyte[])[209, 136]: "&#xe8;", cast(ubyte[])[209, 137]: "&#xe9;",
		cast(ubyte[])[209, 138]: "&#xea;", cast(ubyte[])[209, 139]: "&#xeb;", cast(ubyte[])[209, 140]: "&#xec;", cast(ubyte[])[209, 141]: "&#xed;",
		cast(ubyte[])[209, 142]: "&#xee;", cast(ubyte[])[209, 143]: "&#xef;", cast(ubyte[])[209, 145]: "&#xf1;", cast(ubyte[])[209, 146]: "&#xf2;",
		cast(ubyte[])[209, 147]: "&#xf3;", cast(ubyte[])[209, 148]: "&#xf4;", cast(ubyte[])[209, 149]: "&#xf5;", cast(ubyte[])[209, 150]: "&#xf6;",
		cast(ubyte[])[209, 151]: "&#xf7;", cast(ubyte[])[209, 152]: "&#xf8;", cast(ubyte[])[209, 153]: "&#xf9;", cast(ubyte[])[209, 154]: "&#xfa;",
		cast(ubyte[])[209, 155]: "&#xfb;", cast(ubyte[])[209, 156]: "&#xfc;", cast(ubyte[])[209, 157]: "&#xfd;", cast(ubyte[])[209, 158]: "&#xfe;",
		cast(ubyte[])[209, 159]: "&#xff;"];*/
	write("Content-type: text/vnd.wap.wml; charset=UTF-8\n\n"); //To make sure that non-Latin characters are displayed correctly as well, it is necessory to set the charset to UTF-8.
	if (vraag is null) {
		write("<?xml version=\"1.0\"?>
<!DOCTYPE wml PUBLIC \"-//WAPFORUM//DTD WML 1.1//EN\" \"http://www.wapforum.org/DTD/wml_1.1.xml\">
<wml>
<card id=\"a\" title=\"WapL\">
<p align=\"center\">WAP Translate, powered by DeepL</p>
<p>Source-language code or 'auto':
<input name=\"from\" title=\"Src lang:\" maxlength=\"4\" value=\"\"/>
</p>
<p>Target-language code:
<input name=\"to\" title=\"Target lang:\" maxlength=\"7\" value=\"\"/>
</p>
<p>Text:
<input name=\"txt\" title=\"Text:\" maxlength=\"210\" value=\"\"/>
</p>
<p><a href=\"/trans/sup.wml\">List of supported language codes.</a></p>
<do type=\"accept\" label=\"Translate!\">
<go href=\"/cgi-bin/trans.cgi?from=$(from)&amp;to=$(to)&amp;txt=$(txt)\"/>
</do>
<do type=\"prev\" label=\"Back\">
<prev/>
</do>
</card>
</wml>");
	} else {
		//TODO: Add try-catch structure, so Fehler can be properly handled...
		bool success = true;
		auto oertaal = "";
		auto eindtaal = "";
		auto tekst = "";
		auto verzoek = vraag;//.split('?')[1];
		auto eisen = verzoek.split('&');
		for (int i = 0; i < eisen.length; i++) {
			if (eisen[i].split('=')[0] == "from") {
				oertaal = eisen[i].split('=')[1].toUpper();
				if (!canFind(slangs, oertaal)) {
					success = false;
				}
			} else if (eisen[i].split('=')[0] == "to") {
				eindtaal = eisen[i].split('=')[1].toUpper();
				if (!canFind(elangs, eindtaal)) {
					success = false;
				}
			} else if (eisen[i].split('=')[0] == "txt") {
				tekst = eisen[i].split('=')[1].decode;
			}
		}
		if (success) {
			Response reagent;
			//auto http = HTTP();
			auto bezoek = Request();
			auto tongue = "";
			//auto sleutel = [ "Deepl-Auth-Key:", DIEPSLEUTEL ];
			//write("DeepL-Auth-Key: " ~ DIEPSLEUTEL);
			bezoek.addHeaders(["Authorization": "DeepL-Auth-Key " ~ DIEPSLEUTEL, "Accept-Charset": "UTF-8"]);
			//http.addRequestHeader("Accept-Charset", "UTF-8");
			//http.addRequestHeader("Content-Type", "application/json");
			if (oertaal == "AUTO") {
				reagent = bezoek.post("https://api-free.deepl.com/v2/translate", queryParams("text", tekst, "target_lang", eindtaal));
			} else {
				reagent = bezoek.post("https://api-free.deepl.com/v2/translate", queryParams("text", tekst, "source_lang", oertaal, "target_lang", eindtaal));
			}
			//TODO: Actually use the HTTP response code...
			ushort volgnummer = reagent.code;
			if (volgnummer == 200) {//SUCCESS!
				string reactie = reagent.responseBody.data.assumeUTF; //Bouw char[] om tot string, door in 'reactie' een immutabele versie te plaatsen, daar een string een 'immutable char[]' is.
				JSONValue zoon = parseJSON(reactie);
				string translatio = zoon["translations"][0]["text"].str;
				string adaptatio;
				/*if (eindtaal == "RU") {
					//Set the character encoding to ISO 8859-5
					write(" charset=UTF-8\n\n<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE wml PUBLIC \"-//WAPFORUM//DTD WML 1.1//EN\" \"http://www.wapforum.org/DTD/wml_1.1.xml\">\n<wml>\n<head>\n<meta http-equiv=\"Content-Type\" content=\"text/vnd.wap.wml; charset=UTF-8\"/>\n</head>\n");
					//The char array will hold the new 'string' until it is finished and ready to be moved into a real string .i. an immutable char array.
					char[] imitatio;
					//The ubyte array will be used to store up to two ubytes. The characters we have to replace all consist of two ubytes. So we must put everything in an ubyte array.
					ubyte[2] plagiatio;
					//But only if plagiatio contains two ubytes we should try to find it in ISO_8859_5.
					bool eerste = true;
					for (int i = 0; i < translatio.length; i++) {
						ubyte bitje = cast(immutable(ubyte))translatio[i];
						//If the ubyte's value is less than 128, it will show up just fine, because there they are the same between encodings.
						if (bitje < 128) {
							imitatio ~= bitje;
						} else if (eerste) {
							plagiatio[0] = bitje;
							eerste = false; //Now the array is no longer empty!
						} else {
							plagiatio[1] = bitje;
							// //If the char is in our ISO_8859_5 array, replace it with its escape code.
							//if (plagiatio in ISO_8859_5) {
							//	imitatio ~= ISO_8859_5[plagiatio];
							//}
							eerste = true;
							if (plagiatio[0] == 208) {
								imitatio ~= (plagiatio[1]+32);
							} else  if (plagiatio[0] == 209) {
								imitatio ~= plagiatio[1]+127;
							}
						}
					}
					//Now we have to copy the char array into an immutable char array .i. a string.
					adaptatio = imitatio.idup;
				} else {
					//Charset Latin1 will do.
					write(" charset=ISO-8859-1\n\n<?xml version=\"1.0\"?>\n<!DOCTYPE wml PUBLIC \"-//WAPFORUM//DTD WML 1.1//EN\" \"http://www.wapforum.org/DTD/wml_1.1.xml\">\n<wml>\n");
					adaptatio = translatio;
				}			*/
				adaptatio = translatio;
				if (oertaal == "AUTO") {
					tongue = zoon["translations"][0]["detected_source_language"].str;
				} else {
					tongue = oertaal;
				}
				write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE wml PUBLIC \"-//WAPFORUM//DTD WML 1.1//EN\" \"http://www.wapforum.org/DTD/wml_1.1.xml\">
<wml>
<head>
<meta http-equiv=\"Content-Type\" content=\"text/vnd.wap.wml; charset=UTF-8\"/>
</head>
<card id=\"a\" title=\"WapL\">
<p align=\"center\">WAP Translate, powered by DeepL</p>
<p>Source-language code or 'auto':
<input name=\"from\" title=\"Src lang:\" maxlength=\"4\" value=\"", tongue, "\"/>
</p>
<p>Target-language code:
<input name=\"to\" title=\"Target lang:\" maxlength=\"7\" value=\"", eindtaal, "\"/>
</p>
<p>Text:
<input name=\"txt\" title=\"Text:\" maxlength=\"210\" value=\"", tekst, "\"/>
</p>
<p>Translation: </p>
<p>", adaptatio, "</p>
<p><a href=\"/trans/sup.wml\">List of supported language codes.</a></p>
<do type=\"accept\" label=\"Translate!\">
<go href=\"/cgi-bin/trans.cgi?from=$(from)&amp;to=$(to)&amp;txt=$(txt)\"/>
</do>
<do type=\"prev\" label=\"Back\">
<prev/>
</do>
</card>
</wml>");
			} else {
				//Give ERROR. For other HTTP return codes.
			}
		} else {
			write("<?xml version=\"1.0\"?>
<!DOCTYPE wml PUBLIC \"-//WAPFORUM//DTD WML 1.1//EN\" \"http://www.wapforum.org/DTD/wml_1.1.xml\">
<wml>
<card id=\"a\" title=\"WapL\">
<p align=\"center\">WAP Translate, powered by DeepL</p>
<p><b>Oh No! An error occured! Invalid language code.</b></p>
<p>Source-language code or 'auto':
<input name=\"from\" title=\"Src lang:\" maxlength=\"4\" value=\"", oertaal, "\"/>
</p>
<p>Target-language code:
<input name=\"to\" title=\"Target lang:\" maxlength=\"7\" value=\"", eindtaal, "\"/>
</p>
<p>Text:
<input name=\"txt\" title=\"Text:\" maxlength=\"210\" value=\"", tekst, "\"/>
</p>
<p><a href=\"/trans/sup.wml\">List of supported language codes.</a></p>
<do type=\"accept\" label=\"Translate!\">
<go href=\"/cgi-bin/trans.cgi?from=$(from)&amp;to=$(to)&amp;txt=$(txt)\"/>
</do>
<do type=\"prev\" label=\"Back\">
<prev/>
</do>
</card>
</wml>");
		}
	}
}

/*
  Created by Tim De Smet
  Last edit: 24/05/2021@2100
 
   1  7777777 555555
  111     777 55
   11    777  555555
   11   777      5555
  111  777    555555

  -------[ ENJOY ]-------
  Generates Google Forms link with prefilled SitRep data. If variable "autosubmit" is true, it even submits automatically.
  	Testing of this autosubmission can be done by making lastName empty (= "") and changing autosubmit to true.
*/

var autosubmit = false; // Automatically submit: 'false' -> 'true'
var baselink = "https://docs.google.com/forms/d/1wFMXmX4su9Q8GTagQk0j21K62AxgBtvGsQE6L7rEWRI"

//	-------[ Change the next variables ]-------	 //
var lastName = "Your last name";
var firstName = "Your first name";
var promotion = ["175 POL", "160 SSMW", 1]; // Select which one
var language = ["N", "F", 1];
var matricule = 696969; // Your matricule here
var address = "Your address";
var sports = "Your sports and duration";



// -------[ Optional ]------- //
var whereAbouts = ["Home", "RMA", 1]; // Select which one, if RMA is selected, address will change as well
var mailChecked = ["YES", "NO", 1];
var randsports = ["Run", "Bike", "Strength", "Walk", "Paaldansen", [45, 90], false]; // For the liars, change 'false' in 'true' and it will generate a random sport of duration between 45/90min
var medical = ["P (Completely Ops)", 
		   "PS (I show symptoms of Corona)", 
		   "PSE (People around me show symptoms of Corona)", 
		   "Q (Quarantaine) when you are positive tested", 
		   "I (Isolation) waiting for the result", 
		   "Positive test", 
		   "Negative test", 1];
var questions = "None.";
var remarques = "";

//	!-------[ CHANGE WITH CAUTION ]-------!	 //
var entry = [1981765836, 261023013, 767032974, 1322242599, 239541400, 202815844, 2072704141, 1841305855, 2124830854, 690739259, 1110877319, 1403071410, 1380738579, 1304546116];
var answer = [-1, -1, lastName, firstName, promotion, language, 
				matricule, whereAbouts, address, mailChecked, 
				sports, medical, questions, remarques];

function createLink() {
	if (autosubmit) {
		link = baselink+"/formResponse?";
	} 
	else {
		link = baselink+"/viewform?";
	}

	var d = new Date();
	let today = new Date().toISOString().slice(0, 10)
	answer[0] = today.toString();
	if (d.getHours().toString().length != 2) {
		answer[1] = "0"+d.getHours().toString();
	}
	else {
		answer[1] = d.getHours().toString();
	}

	if (d.getMinutes().toString().length != 2) {
		answer[1]+=":"+"0"+d.getMinutes().toString();
	}
	else {
		answer[1]+=":"+d.getMinutes().toString();
	}
	if (randsports[randsports.length-1]) {
		//Math.floor(Math.random() * array.length)
		//todo
		answer[10] = "${randsports[rand(1:(randsports.length-2))]}"+"-"+"${rand(randsports[randsports.length-2-1][1]:randsports[randsports.length-2-1][2])}"+"min";
	}

	for (i = 0; i <= entry.length; i++) {
		if (Array.isArray(answer[i])) {
			link+="entry."+entry[i]+"="+answer[i][answer[i][answer[i].length-1]-1];
			if (i < entry.length) {
				link+="&";
			}
		} 
		else {
			link+="entry."+entry[i]+"="+answer[i];
			if (i < entry.length) {
				link+="&";
			}
		}
	}

	if (autosubmit) {
		link+="&submit=Submit";
	}

 	document.getElementById("link").innerHTML = link;
}

function test() {

	var yeet = "yeet";
	var derp = "derp";
	var mkay = derp+yeet;

	console.log(mkay);

	var d = new Date();

	a = d.getHours();
	console.log(a.toString());
	console.log(a.toString().length);
}
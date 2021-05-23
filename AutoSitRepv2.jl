"""
  Created by Tim De Smet
  Last edit: 23/05/2021@1210
 
   1  7777777 555555
  111     777 55
   11    777  555555
   11   777      5555
  111  777    555555

  -------[ ENJOY ]-------
  Generates Google Forms link with prefilled SitRep data. If variable "autosubmit" is true, it even submits automatically.
  	Testing of this autosubmission can be done by making lastName empty (= "") and changing autosubmit to true.

"""
# todo: dictionary, messenger bot

global autosubmit = false # Automatically submit: 'false' -> 'true'

#	-------[ Change the next variables ]-------	 #
lastName = "Your last name"
firstName = "Your first name"
promotion = ["175 POL", "160 SSMW", 1] # Select which one
language = ["N", "F", 1]
matricule = 696969 # Your matricule here
address = "Your address"
sports = "Your sports and duration"



# -------[ Optional ]------- #
whereAbouts = ["Home", "RMA", 1] # Select which one, if RMA is selected, address will change as well
mailChecked = ["YES", "NO", 1]
randsports = ["Run", "Bike", "Strength", "Walk", "Paaldansen", [45, 90], false] # For the liars, change 'false' in 'true' and it will generate a random sport of duration between 45/90min
medical = ["P (Completely Ops)", 
		   "PS (I show symptoms of Corona)", 
		   "PSE (People around me show symptoms of Corona)", 
		   "Q (Quarantaine) when you are positive tested", 
		   "I (Isolation) waiting for the result", 
		   "Positive test", 
		   "Negative test", 1]
questions = "None."
remarques = ""

#	!-------[ CHANGE WITH CAUTION ]-------!	 #
using Dates
global entry = [1981765836, 261023013, 767032974, 1322242599, 239541400, 202815844, 2072704141, 1841305855, 2124830854, 690739259, 1110877319, 1403071410, 1380738579, 1304546116]
global baselink = "https://docs.google.com/forms/d/1wFMXmX4su9Q8GTagQk0j21K62AxgBtvGsQE6L7rEWRI"
global answer = [-1, -1, lastName, firstName, promotion, language, 
				matricule, whereAbouts, address, mailChecked, 
				sports, medical, questions, remarques]
function createLink()
	global entry
	global baselink
	global answer

	if autosubmit
		link = baselink*"/formResponse?"
	else
		link = baselink*"/viewform?"
	end

	answer[1] = string(Dates.today())
	if length(string(Dates.hour(now()))) != 2
		answer[2] = "0"*string(Dates.hour(now()))
	else 
		answer[2] = string(Dates.hour(now()))
	end
	if length(string(Dates.minute(now()))) != 2
		answer[2]*=":"*"0"*string(Dates.minute(now()))
	else
		answer[2]*=":"*string(Dates.minute(now()))
	end
	if randsports[end]
		answer[11] = "$(randsports[rand(1:(length(randsports)-2))])"*"-"*"$(rand(randsports[end-1][1]:randsports[end-1][2]))"*"min"
	end

	for i in eachindex(entry)
		if isa(answer[i], Array)
			link*="entry.$(entry[i])=$(answer[i][answer[i][end]])"
			if i < length(entry)
				link*="&"
			end
		else
			link*="entry.$(entry[i])=$(answer[i])"
			if i < length(entry)
				link*="&"
			end
		end
	end

	if autosubmit
		link*="&submit=Submit"
	end

	println("Generated link:")
	println()
	println(link)
	io = open("AutoSitRepGeneratedLink.txt", lock = true, append = true)
		println(io, "@"*string(DateTime(now()))*": ")
		println(io, link)
	close(io)
end
createLink()
println()
println("Done.")
"""
  Created by Tim De Smet
  Last edit: 25/05/2021@1540
 
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

autosubmit = false; # Automatically submit: 'false' -> 'true'
baselink = "https://docs.google.com/forms/d/1wFMXmX4su9Q8GTagQk0j21K62AxgBtvGsQE6L7rEWRI"

#	-------[ Change the next variables ]-------	 #
lastName = "Your last name";
firstName = "Your first name";
promotion = ["160 SSMW", "175 POL", 2]; # Select which one
language = ["F", "N", 2];
matricule = 696969; # Your matricule here
address = "Your address here";
sports = "Your Sports here";



# -------[ Optional ]------- #
whereAbouts = ["RMA", "Other", 1]; # Select which one, if RMA is selected, address will change as well
mailChecked = ["Yes", "No", 1];
randsports = ["Run", "Bike", "Strength", "Walk", "Paaldansen", [45, 90], false]; # For the liars, change 'false' in 'true' and it will generate a random sport of duration between 45/90min
medical = ["P (Completely Ops)", 
		   "PS (I show symptoms of Corona and confirmed)", 
		   "PSE (My entourage shows symptoms of Corona and confirmed)", 
		   "Q (Quarantaine)", 
		   "Positive test", 
		   "Negative test", 
		   "AGR/AMS (no Corona)", 1];
questions = "None.";
remarques = "";

#	!-------[ CHANGE WITH CAUTION ]-------!	 #
using Dates
entry = [2098902328, 735224320, 110406996, 970617568, 1416870757, 533365005, 791227354, 1716620882, 529903153, 946171575, 712245977, 404233749, 1380738579, 544884552]
baselink = "https://docs.google.com/forms/d/1wFMXmX4su9Q8GTagQk0j21K62AxgBtvGsQE6L7rEWRI"
answer = [-1, -1, lastName, firstName, promotion, 
				matricule, whereAbouts, address, mailChecked, 
				sports, medical, questions, remarques, language]
function createLink()
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
	if whereAbouts[whereAbouts[end]] == "RMA"
		answer[8] = "RMA"
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
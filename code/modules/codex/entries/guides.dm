/datum/codex_entry/guide
	abstract_type = /datum/codex_entry/guide
	lore_text = "This guide has not been written yet, sorry!"

/datum/codex_entry/guide/New()
	..()
	if(QDELETED(src))
		return

	// Add to category.
	var/decl/codex_category/cat = GET_DECL(/decl/codex_category/guides)
	LAZYDISTINCTADD(categories, cat)
	LAZYDISTINCTADD(cat.items, name)

	// Generate our guide text.
	guide_html = guide_html ? list(guide_html) : list()
	if(lore_text)
		guide_html += "<p>[lore_text]</p>"
	if(mechanics_text)
		guide_html += "<p>[mechanics_text]</p>"
	// No antag text for the guide text.
	guide_html = JOINTEXT(guide_html)

/datum/codex_entry/guide/robotics
	name = "Guide to Robotics"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1>Cyborgs for Dummies</h1>

		<h2>Chapters</h2>
		<ol>
			<li><a href="#Equipment">Cyborg Related Equipment</a></li>
			<li><a href="#Modules">Cyborg Modules</a></li>
			<li><a href="#Construction">Cyborg Construction</a></li>
			<li><a href="#Maintenance">Cyborg Maintenance</a></li>
			<li><a href="#Repairs">Cyborg Repairs</a></li>
			<li><a href="#Emergency">In Case of Emergency</a></li>
		</ol>

		<h2><a name="Equipment">Cyborg Related Equipment</h2>

		<h3>Exosuit Fabricator</h3>
		The Exosuit Fabricator is the most important piece of equipment related to cyborgs. It allows the construction of the core cyborg parts. Without these machines, cyborgs cannot be built. It seems that they may also benefit from advanced research techniques.

		<h3>Cyborg Recharging Station</h3>
		This useful piece of equipment will suck power out of the power systems to charge a cyborg's power cell back up to full charge.

		<h3>Robotics Control Console</h3>
		This useful piece of equipment can be used to immobilize or destroy a cyborg. A word of warning: Cyborgs are expensive pieces of equipment, do not destroy them without good reason, or the Company may see to it that it never happens again.

		<h2><a name="Modules">Cyborg Modules</h2>
		When a cyborg is created it picks out of an array of modules to designate its purpose. There are 11 different cyborg modules.<br>
		All cyborg modules carry a flash.

		# TODO generate from SSrobots

		<h2><a name="Construction">Cyborg Construction</h2>
		Cyborg construction is a rather easy process, requiring a decent amount of metal and a few other supplies.<br>The required materials to make a cyborg are:
		<ul>
		  <li>Metal</li>
		  <li>Two Flashes</li>
		  <li>One Power Cell (Preferably rated to 15000w)</li>
		  <li>Some electrical wires</li>
		  <li>One Human Brain</li>
		  <li>One Man-Machine Interface</li>
		</ul>
		Once you have acquired the materials, you can start on construction of your cyborg.<br>To construct a cyborg, follow the steps below:
		<ol>
		  <li>Start the Exosuit Fabricators constructing all of the cyborg parts</li>
		  <li>While the parts are being constructed, take your human brain, and place it inside the Man-Machine Interface</li>
		  <li>Once you have a Robot Head, place your two flashes inside the eye sockets</li>
		  <li>Once you have your Robot Chest, wire the Robot chest, then insert the power cell</li>
		  <li>Attach all of the Robot parts to the Robot frame</li>
		  <li>Insert the Man-Machine Interface (With the Brain inside) into the Robot Body</li>
		  <li>Congratulations! You have a new cyborg!</li>
		</ol>

		<h2><a name="Maintenance">Cyborg Maintenance</h2>
		Occasionally Cyborgs may require maintenance of a couple types, this could include replacing a power cell with a charged one, or possibly maintaining the cyborg's internal wiring.

		<h3>Replacing a Power Cell</h3>
		Replacing a Power cell is a common type of maintenance for cyborgs. It usually involves replacing the cell with a fully charged one, or upgrading the cell with a larger capacity cell.<br>The steps to replace a cell are as follows:
		<ol>
		  <li>Unlock the Cyborg's Interface by swiping your ID on it</li>
		  <li>Open the Cyborg's outer panel using a crowbar</li>
		  <li>Remove the old power cell</li>
		  <li>Insert the new power cell</li>
		  <li>Close the Cyborg's outer panel using a crowbar</li>
		  <li>Lock the Cyborg's Interface by swiping your ID on it, this will prevent non-qualified personnel from attempting to remove the power cell</li>
		</ol>

		<h3>Exposing the Internal Wiring</h3>
		Exposing the internal wiring of a cyborg is fairly easy to do, and is mainly used for cyborg repairs.<br>You can easily expose the internal wiring by following the steps below:
		<ol>
			<li>Follow Steps 1 - 3 of "Replacing a Cyborg's Power Cell"</li>
			<li>Open the cyborg's internal wiring panel by using a screwdriver to unsecure the panel</li>
		</ol>
		To re-seal the cyborg's internal wiring:
		<ol>
			<li>Use a screwdriver to secure the cyborg's internal panel</li>
			<li>Follow steps 4 - 6 of "Replacing a Cyborg's Power Cell" to close up the cyborg</li>
		</ol>

		<h2><a name="Repairs">Cyborg Repairs</h2>
		Occasionally a Cyborg may become damaged. This could be in the form of impact damage from a heavy or fast-travelling object, or it could be heat damage from high temperatures, or even lasers or Electromagnetic Pulses (EMPs).

		<h3>Dents</h3>
		If a cyborg becomes damaged due to impact from heavy or fast-moving objects, it will become dented. Sure, a dent may not seem like much, but it can compromise the structural integrity of the cyborg, possibly causing a critical failure.
		Dents in a cyborg's frame are rather easy to repair, all you need is to apply a welding tool to the dented area, and the high-tech cyborg frame will repair the dent under the heat of the welder.

		<h3>Excessive Heat Damage</h3>
		If a cyborg becomes damaged due to excessive heat, it is likely that the internal wires will have been damaged. You must replace those wires to ensure that the cyborg remains functioning properly.<br>To replace the internal wiring follow the steps below:
		<ol>
			<li>Unlock the Cyborg's Interface by swiping your ID</li>
			<li>Open the Cyborg's External Panel using a crowbar</li>
			<li>Remove the Cyborg's Power Cell</li>
			<li>Using a screwdriver, expose the internal wiring of the Cyborg</li>
			<li>Replace the damaged wires inside the cyborg</li>
			<li>Secure the internal wiring cover using a screwdriver</li>
			<li>Insert the Cyborg's Power Cell</li>
			<li>Close the Cyborg's External Panel using a crowbar</li>
			<li>Lock the Cyborg's Interface by swiping your ID</li>
		</ol>
		These repair tasks may seem difficult, but are essential to keep your cyborgs running at peak efficiency.

		<h2><a name="Emergency">In Case of Emergency</h2>
		In case of emergency, there are a few steps you can take.

		<h3>"Rogue" Cyborgs</h3>
		If the cyborgs seem to become "rogue", they may have non-standard laws. In this case, use extreme caution.
		To repair the situation, follow these steps:
		<ol>
			<li>Locate the nearest robotics console</li>
			<li>Determine which cyborgs are "Rogue"</li>
			<li>Press the lockdown button to immobilize the cyborg</li>
			<li>Locate the cyborg</li>
			<li>Expose the cyborg's internal wiring</li>
			<li>Check to make sure the LawSync and AI Sync lights are lit</li>
			<li>If they are not lit, pulse the LawSync wire using a multitool to enable the cyborg's LawSync</li>
			<li>Proceed to a cyborg upload console. The Company usually places these in the same location as AI upload consoles.</li>
			<li>Use a "Reset" upload moduleto reset the cyborg's laws</li>
			<li>Proceed to a Robotics Control console</li>
			<li>Remove the lockdown on the cyborg</li>
		</ol>

		<h3>As a last resort</h3>
		If all else fails in a case of cyborg-related emergency, there may be only one option. Using a Robotics Control console, you may have to remotely detonate the cyborg.
		<h3>WARNING:</h3> Do not detonate a borg without an explicit reason for doing so. Cyborgs are expensive pieces of company equipment, and you may be punished for detonating them without reason.
	"}

/datum/codex_entry/guide/detective
	name = "Guide to Forensics"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1>Detective Work</h1>
		Between your bouts of self-narration and drinking whiskey on the rocks, you might get a case or two to solve.<br>
		To have the best chance to solve your case, follow these directions:
		<p>
		<ol>
			<li>Go to the crime scene. </li>
			<li>Take your scanner and scan EVERYTHING (Yes, the doors, the tables, even the dog). </li>
			<li>Once you are reasonably certain you have every scrap of evidence you can use, find all possible entry points and scan them, too. </li>
			<li>Return to your office. </li>
			<li>Using your forensic scanning computer, scan your scanner to upload all of your evidence into the database.</li>
			<li>Browse through the resulting dossiers, looking for the one that either has the most complete set of prints, or the most suspicious items handled. </li>
			<li>If you have 80% or more of the print (The print is displayed), go to step 10, otherwise continue to step 8.</li>
			<li>Look for clues from the suit fibres you found on your perpetrator, and go about looking for more evidence with this new information, scanning as you go. </li>
			<li>Try to get a fingerprint card of your perpetrator, as if used in the computer, the prints will be completed on their dossier.</li>
			<li>Assuming you have enough of a print to see it, grab the biggest complete piece of the print and search the security records for it. </li>
			<li>Since you now have both your dossier and the name of the person, print both out as evidence and get security to nab your baddie.</li>
			<li>Give yourself a pat on the back and a bottle of the ship's finest vodka, you did it!</li>
		</ol>
		<p>
		It really is that easy! Good luck!
	"}

/datum/codex_entry/guide/nuclear_sabotage
	name = "Guide to Nuclear Sabotage"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1>Nuclear Explosives 101</h1>
		Hello and thank you for choosing the Syndicate for your nuclear information needs. Today's crash course will deal with the operation of a Nuclear Fission Device.<br><br>

		First and foremost, DO NOT TOUCH ANYTHING UNTIL THE BOMB IS IN PLACE. Pressing any button on the compacted bomb will cause it to extend and bolt itself into place. If this is done, to unbolt it, one must completely log in, which at this time may not be possible.<br>

		<h2>To make the nuclear device functional</h2>
		<ul>
			<li>Place the nuclear device in the designated detonation zone.</li>
			<li>Extend and anchor the nuclear device from its interface.</li>
			<li>Insert the nuclear authorisation disk into the slot.</li>
			<li>Type the numeric authorisation code into the keypad. This should have been provided.<br>
			<b>Note</b>: If you make a mistake, press R to reset the device.
			<li>Press the E button to log on to the device.</li>
		</ul><br>

		You now have activated the device. To deactivate the buttons at anytime, for example when you've already prepped the bomb for detonation, remove the authentication disk OR press R on the keypad.<br><br>
		Now the bomb CAN ONLY be detonated using the timer. Manual detonation is not an option. Toggle off the SAFETY.<br>
		<b>Note</b>: You wouldn't believe how many Syndicate Operatives with doctorates have forgotten this step.<br><br>

		So use the - - and + + to set a detonation time between 5 seconds and 10 minutes. Then press the timer toggle button to start the countdown. Now remove the authentication disk so that the buttons deactivate.<br>
		<b>Note</b>: THE BOMB IS STILL SET AND WILL DETONATE<br><br>

		Now before you remove the disk, if you need to move the bomb, you can toggle off the anchor, move it, and re-anchor.<br><br>

		Remember the order:<br>
		<b>Disk, Code, Safety, Timer, Disk, RUN!</b><br><br>
		Intelligence Analysts believe that normal corporate procedure is for the Captain to secure the nuclear authentication disk.<br><br>

		Good luck!
	"}

/datum/codex_entry/guide/particle_accelerator
	name = "Guide to Particle Accelerators"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1>Experienced User's Guide</h1>
		<h2>Setting up the accelerator</h2>
		<ol>
			<li><b>Wrench</b> all pieces to the floor</li>
			<li>Add <b>wires</b> to all the pieces</li>
			<li>Close all the panels with your <b>screwdriver</b></li>
		</ol>
		<h2>Using the accelerator</h2>
		<ol>
			<li>Open the control panel</li>
			<li>Set the speed to 2</li>
			<li>Start firing at the singularity generator</li>
			<li><font color='red'><b>When the singularity reaches a large enough size so it starts moving on it's own set the speed down to 0, but don't shut it off</b></font></li>
			<li>Remember to wear a radiation suit when working with this machine... we did tell you that at the start, right?</li>
		</ol>
	"}


/datum/codex_entry/guide/singularity
	name = "Guide to Singularity Engines"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1>Singularity Safety in Special Circumstances</h1>
		<h2>Power outage</h2>
		A power problem has made you lose power? Could be wiring problems or syndicate power sinks. In any case follow these steps:
		<ol>
			<li><b><font color='red'>PANIC!</font></b></li>
			<li>Get your ass over to engineering! <b>QUICKLY!!!</b></li>
			<li>Get to the <b>Area Power Controller</b> which controls the power to the emitters.</li>
			<li>Swipe it with your <b>ID card</b> - if it doesn't unlock, continue with step 15.</li>
			<li>Open the console and disengage the cover lock.</li>
			<li>Pry open the APC with a <b>Crowbar.</b></li>
			<li>Take out the empty <b>power cell.</b></li>
			<li>Put in the new, <b>full power cell</b> - if you don't have one, continue with step 15.</li>
			<li>Quickly put on a <b>Radiation suit.</b></li>
			<li>Check if the <b>singularity field generators</b> withstood the down-time - if they didn't, continue with step 15.</li>
			<li>Since disaster was averted you now have to ensure it doesn't repeat. If it was a powersink which caused it and if the engineering APC is wired to the same powernet, which the powersink is on, you have to remove the piece of wire which links the APC to the powernet. If it wasn't a powersink which caused it, then skip to step 14.</li>
			<li>Grab your crowbar and pry away the tile closest to the APC.</li>
			<li>Use the wirecutters to cut the wire which is connecting the grid to the terminal. </li>
			<li>Go to the bar and tell the guys how you saved them all. Stop reading this guide here.</li>
			<li><b>GET THE FUCK OUT OF THERE!!!</b></li>
		</ol>
		<h2>Shields get damaged</h2>
		<ol>
			<li><b>GET THE FUCK OUT OF THERE!!! FORGET THE WOMEN AND CHILDREN, SAVE YOURSELF!!!</b></li>
		</ol>
	"}

/datum/codex_entry/guide/mech_construction
	name = "Guide to Exosuit Construction"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<center>
		<br>
		<span style='font-size: 12px;'><b>Weyland-Yutani - Building Better Worlds</b></span>
		<h1>Autonomous Power Loader Unit \"Ripley\"</h1>
		</center>
		<h2>Specifications:</h2>
		<ul class="a">
		<li><b>Class:</b> Autonomous Power Loader</li>
		<li><b>Scope:</b> Logistics and Construction</li>
		<li><b>Weight:</b> 820kg (without operator and with empty cargo compartment)</li>
		<li><b>Height:</b> 2.5m</li>
		<li><b>Width:</b> 1.8m</li>
		<li><b>Top speed:</b> 5km/hour</li>
		<li><b>Operation in vacuum/hostile environment: Possible</b>
		<li><b>Airtank volume:</b> 500 liters</li>
		<li><b>Devices:</b>
			<ul class="a">
			<li>Hydraulic clamp</li>
			<li>High-speed drill</li>
			</ul>
		</li>
		<li><b>Propulsion device:</b> Powercell-powered electro-hydraulic system</li>
		<li><b>Powercell capacity:</b> Varies</li>
		</ul>
		<h2>Construction:</h2>
		<ol>
			<li>Connect all exosuit parts to the chassis frame.</li>
			<li>Connect all hydraulic fittings and tighten them up with a wrench.</li>
			<li>Adjust the servohydraulics with a screwdriver.</li>
			<li>Wire the chassis (Cable is not included).</li>
			<li>Use the wirecutters to remove the excess cable if needed.</li>
			<li>Install the central control module (Not included. Use supplied datadisk to create one).</li>
			<li>Secure the mainboard with a screwdriver.</li>
			<li>Install the peripherals control module (Not included. Use supplied datadisk to create one).</li>
			<li>Secure the peripherals control module with a screwdriver.</li>
			<li>Install the internal armor plating (Not included due to corporate regulations. Can be made using 5 metal sheets).</li>
			<li>Secure the internal armor plating with a wrench.</li>
			<li>Weld the internal armor plating to the chassis.</li>
			<li>Install the external reinforced armor plating (Not included due to corporate regulations. Can be made using 5 reinforced metal sheets).</li>
			<li>Secure the external reinforced armor plating with a wrench.</li>
			<li>Weld the external reinforced armor plating to the chassis.</li>
		</ol>
		<h2>Additional Information:</h2>
		<ul>
			<li>The firefighting variation is made in a similar fashion.</li>
			<li>A firesuit must be connected to the firefighter chassis for heat shielding.</li>
			<li>Internal armor is plasteel for additional strength.</li>
			<li>External armor must be installed in 2 parts, totalling 10 sheets.</li>
			<li>Completed exosuit is more resilient against fire, and is a bit more durable overall.</li>
			<li>The Company is determined to ensure the safety of its <s>investments</s> employees.</li>
		</ul>
		</body>
	"}

/datum/codex_entry/guide/atmospherics
	name = "Guide to Atmospherics"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1><a name="Contents">Contents</a></h1>
		<ol>
			<li><a href="#Foreword">Author's Foreword</a></li>
			<li><a href="#Basic">Basic Piping</a></li>
			<li><a href="#Insulated">Insulated Pipes</a></li>
			<li><a href="#Devices">Atmospherics Devices</a></li>
			<li><a href="#HES">Heat Exchange Systems</a></li>
			<li><a href="#Final">Final Checks</a></li>
		</ol><br>
		<h1><a name="Foreword"><U><B>HOW TO NOT SUCK QUITE SO HARD AT ATMOSPHERICS</B></U></a></h1><BR>
		<I>Or: What the fuck does a "pressure regulator" do?</I><BR><BR>
		Alright. It has come to my attention that a variety of people are unsure of what a "pipe" is and what it does.
		Apparently, there is an unnatural fear of these arcane devices and their "gases." Spooky, spooky. So,
		this will tell you what every device constructable by an ordinary pipe dispenser within atmospherics actually does.
		You are not going to learn what to do with them to be the super best person ever, or how to play guitar with passive gates,
		or something like that. Just what stuff does.<BR><BR>
		<h1><a name="Basic"><B>Basic Pipes</B></a></h1>
		<I>The boring ones.</I><BR>
		Most ordinary pipes are pretty straightforward. They hold gas. If gas is moving in a direction for some reason, gas will flow in that direction.
		That's about it. Even so, here's all of your wonderful pipe options.<BR>
		<ul>
		<li><b>Straight pipes:</b> They're pipes. One-meter sections. Straight line. Pretty simple. Just about every pipe and device is based around this
		standard one-meter size, so most things will take up as much space as one of these.</li>
		<li><b>Bent pipes:</b> Pipes with a 90 degree bend at the half-meter mark. My goodness.</li>
		<li><b>Pipe manifolds:</b> Pipes that are essentially a "T" shape, allowing you to connect three things at one point.</li>
		<li><b>4-way manifold:</b> A four-way junction.</li>
		<li><b>Pipe cap:</b> Caps off the end of a pipe. Open ends don't actually vent air, because of the way the pipes are assembled, so, uh, use them to decorate your house or something.</li>
		<li><b>Manual valve:</b> A valve that will block off airflow when turned. Can't be used by the AI or cyborgs, because they don't have hands.</li>
		<li><b>Manual T-valve:</b> Like a manual valve, but at the center of a manifold instead of a straight pipe.</li><BR><BR>
		</ul>
		An important note here is that pipes are now done in three distinct lines - general, supply, and scrubber. You can move gases between these with a universal adapter. Use the correct position for the correct location.
		Connecting scrubbers to a supply position pipe makes you an idiot who gives everyone a difficult job. Insulated and HE pipes don't go through these positions.
		<h1><a name="Insulated"><B>Insulated Pipes</B></a></h1>
		<li><I>Bent pipes:</I> Pipes with a 90 degree bend at the half-meter mark. My goodness.</li>
		<li><I>Pipe manifolds:</I> Pipes that are essentially a "T" shape, allowing you to connect three things at one point.</li>
		<li><I>4-way manifold:</I> A four-way junction.</li>
		<li><I>Pipe cap:</I> Caps off the end of a pipe. Open ends don't actually vent air, because of the way the pipes are assembled, so, uh. Use them to decorate your house or something.</li>
		<li><I>Manual Valve:</I> A valve that will block off airflow when turned. Can't be used by the AI or cyborgs, because they don't have hands.</li>
		<li><I>Manual T-Valve:</I> Like a manual valve, but at the center of a manifold instead of a straight pipe.</li><BR><BR>
		<h1><a name="Insulated"><B>Insulated Pipes</B></a></h1><BR>
		<I>Special Public Service Announcement.</I><BR>
		Our regular pipes are already insulated. These are completely worthless. Punch anyone who uses them.<BR><BR>
		<h1><a name="Devices"><B>Devices: </B></a></h1>
		<I>They actually do something.</I><BR>
		This is usually where people get frightened, afraid, and start calling on their gods and/or cowering in fear. Yes, I can see you doing that right now.
		Stop it. It's unbecoming. Most of these are fairly straightforward.<BR>
		<ul>
		<li><b>Gas pump:</b> Take a wild guess. It moves gas in the direction it's pointing (marked by the red line on one end). It moves it based on pressure, the maximum output being 15000 kPa (kilopascals).
		Ordinary atmospheric pressure, for comparison, is 101.3 kPa, and the minimum pressure of room-temperature pure oxygen needed to not suffocate in a matter of minutes is 16 kPa
		(though 18 kPa is preferred when using internals with pure oxygen, for various reasons). A high-powered variant will move gas more quickly at the expense of consuming more power. Do not turn the distribution loop up to 15000 kPa.
		You will make engiborgs cry and the Chief Engineer will beat you.</li>
		<li><b>Pressure regulator:</b> These replaced the old passive gates. You can choose to regulate pressure by input or output, and regulate flow rate. Regulating by input means that when input pressure is above the limit, gas will flow.
		Regulating by output means that when pressure is below the limit, gas will flow. Flow rate can be controlled.</li>
		<li><b>Unary vent:</b> The basic vent used in rooms. It pumps gas into the room, but can't suck it back out. Controlled by the room's air alarm system.</li>
		<li><b>Scrubber:</b> The other half of room equipment. Filters air, and can suck it in entirely in what's called a "panic siphon." Activating a panic siphon without very good reason will kill someone. Don't do it.</li>
		<li><b>Meter:</b> A little box with some gauges and numbers. Fasten it to any pipe or manifold and it'll read you the pressure in it. Very useful.</li>
		<li><b>Gas mixer:</b> Two sides are input, one side is output. Mixes the gases pumped into it at the ratio defined. The side perpendicular to the other two is "node 2," for reference, on non-mirrored mixers.
		Output is controlled by flow rate. There is also an "omni" variant that allows you to set input and output sections freely.</li>
		<li><b>Gas filter:</b> Essentially the opposite of a gas mixer. One side is input. The other two sides are output. One gas type will be filtered into the perpendicular output pipe,
		the rest will continue out the other side. Can also output from 0-4500 kPa. The "omni" vairant allows you to set input and output sections freely.</li>
		</ul>
		<h1><a name="HES"><B>Heat Exchange Systems</B></a></h1>
		<I>Will not set you on fire.</I><BR>
		These systems are used to only transfer heat between two pipes. They will not move gases or any other element, but will equalize the temperature (eventually). Note that because of how gases work (remember: pv=nRt),
		a higher temperature will raise pressure, and a lower one will lower temperature.<BR>
		<li><I>Pipe:</I> This is a pipe that will exchange heat with the surrounding atmosphere. Place in fire for superheating. Place in space for supercooling.</li>
		<li><I>Bent pipe:</I> Take a wild guess.</li>
		<li><I>Junction:</I> The point where you connect your normal pipes to heat exchange pipes. Not necessary for heat exchangers, but necessary for H/E pipes/bent pipes.</li>
		<li><I>Heat exchanger:</I> These funky-looking bits attach to an open pipe end. Put another heat exchanger directly across from it, and you can transfer heat across two pipes without having to have the gases touch.
		This normally shouldn't exchange with the ambient air, despite being totally exposed. Just don't ask questions.</li><BR>
		That's about it for pipes. Go forth, armed with this knowledge, and try not to break, burn down, or kill anything. Please.
	"}

/datum/codex_entry/guide/eva
	name = "Guide to EVA"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1><a name="Foreword">EVA Gear and You: Not Spending All Day Inside</a></h1>
		<I>Or: How not to suffocate because there's a hole in your shoes</I><BR>
		<h2><a name="Contents">Contents</a></h2>
		<ol>
			<li><a href="#Foreword">A foreword on using EVA gear</a></li>
			<li><a href="#Civilian">Donning a Civilian Suit</a></li>
			<li><a href="#Hardsuit">Putting on a Hardsuit</a></li>
			<li><a href="#Equipment">Cyclers and Other Modification Equipment</a></li>
			<li><a href="#Final">Final Checks</a></li>
		</ol>
		<br>
		EVA gear. Wonderful to use. It's useful for mining, engineering, and occasionally just surviving, if things are that bad. Most people have EVA training,
		but apparently there are some people out in space who don't. This guide should give you a basic idea of how to use this gear, safely. It's split into two sections:
		Civilian suits and hardsuits.<BR><BR>
		<h2><a name="Civilian">Civilian Suits</a></h2>
		<I>The bulkiest things this side of Alpha Centauri</I><BR>
		These suits are the grey ones that are stored in EVA. They're the more simple to get on, but are also a lot bulkier, and provide less protection from environmental hazards such as radiation or physical impact.
		As Medical, Engineering, Security, and Mining all have hardsuits of their own, these don't see much use, but knowing how to put them on is quite useful anyways.<BR><BR>
		First, take the suit. It should be in three pieces: A top, a bottom, and a helmet. Put the bottom on first, shoes and the like will fit in it. If you have magnetic boots, however,
		put them on on top of the suit's feet. Next, get the top on, as you would a shirt. It can be somewhat awkward putting these pieces on, due to the makeup of the suit,
		but to an extent they will adjust to you. You can then find the snaps and seals around the waist, where the two pieces meet. Fasten these, and double-check their tightness.
		The red indicators around the waist of the lower half will turn green when this is done correctly. Next, put on whatever breathing apparatus you're using, be it a gas mask or a breath mask. Make sure the oxygen tube is fastened into it.
		Put on the helmet now, straightforward, and make sure the tube goes into the small opening specifically for internals. Again, fasten seals around the neck, a small indicator light in the inside of the helmet should go from red to off when all is fastened.
		There is a small slot on the side of the suit where an emergency oxygen tank or extended emergency oxygen tank will fit,
		but it is recommended to have a full-sized tank on your back for EVA.<BR><BR>
		These suits tend to be wearable by most species. They're large and flexible. They might be pretty uncomfortable for some, though, so keep that in mind.<BR><BR>
		<h2><a name="Hardsuit">Hardsuits</a></h2>
		<I>Heavy, uncomfortable, still the best option.</I><BR>
		These suits come in Engineering, Mining, and the Armory. There's also a couple Medical Hardsuits in EVA. These provide a lot more protection than the standard suits.<BR><BR>
		Similarly to the other suits, these are split into three parts. Fastening the pant and top are mostly the same as the other spacesuits, with the exception that these are a bit heavier,
		though not as bulky. The helmet goes on differently, with the air tube feeding into the suit and out a hole near the left shoulder, while the helmet goes on turned ninety degrees counter-clockwise,
		and then is screwed in for one and a quarter full rotations clockwise, leaving the faceplate directly in front of you. There is a small button on the right side of the helmet that activates the helmet light.
		The tanks that fasten onto the side slot are emergency tanks, as well as full-sized oxygen tanks, leaving your back free for a backpack or satchel.<BR><BR>
		These suits generally only fit one species. Standard-issue suits are usually human-fitting by default, but there's equipment that can make modifications to the hardsuits to fit them to other species.<BR><BR>
		<h2><a name="Equipment">Modification Equipment</a></h2>
		<I>How to actually make hardsuits fit you.</I><BR>
		There's a variety of equipment that can modify hardsuits to fit species that can't fit into them, making life quite a bit easier.<BR><BR>
		The first piece of equipment is a suit cycler. This is a large machine resembling the storage pods that are in place in some places. These are machines that will automatically tailor a suit to certain specifications.
		The largest uses of them are for their cleaning functions and their ability to tailor suits for a species. Do not enter them physically. You will die from any of the functions being activated, and it will be painful.
		These machines can both tailor a suit between species, and between types. This means you can convert engineering hardsuits to atmospherics, or the other way. This is useful. Use it if you can.<BR><BR>
		There's also modification kits that let you modify suits yourself. These are extremely difficult to use unless you understand the actual construction of the suit. I do not recommend using them unless no other option is available.
		<h2><a name="Final">Final Checks</a></h2>
		<ul>
			<li>Are all seals fastened correctly?</li>
			<li>If you have modified it manually, is absolutely everything sealed perfectly?</li>
			<li>Do you either have shoes on under the suit, or magnetic boots on over it?</li>
			<li>Do you have a mask on and internals on the suit or your back?</li>
			<li>Do you have a way to communicate with your fellow crew in case something goes wrong?</li>
			<li>Do you have a second person watching if this is a training session?</li><BR>
		</ul>
		If you don't have any further issues, go out and do whatever is necessary.
	"}

/datum/codex_entry/guide/xenoarchaeology
	name = "Guide to Xenoarchaeology"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1><a name="Contents">Contents</a></h1>
		<ol>
			<li><a href="#Prep">Prepping the expedition</a></li>
			<li><a href="#Tools">Knowing your tools</a></li>
			<li><a href="#Find">Finding the dig</a></li>
			<li><a href="#Analyse">Analysing deposits</a></li>
			<li><a href="#Excavate">Extracting your first find</a></li>
		</ol>
		<br>
		<h1><a name="Prep">Prepping the expedition</a></h1>
		Every digsite I've been to, someone has forgotten something and I've never yet been to a dig that hasn't had me hiking to get to it - so gather your gear
		and get it to the site the first time. You learn quick that time is money, when you've got a shipful of bandits searching for you the next valley over,
		but don't be afraid to clear some space if there are any inconvenient boulders in the way.<br>
		<ul>
			<li>Floodlights (if it's dark)</li>
			<li>Wooden trestle tables (for holding tools and finds)</li>
			<li>Suspension field generator</li>
			<li>Load bearing servitors (such as a mulebot, or hover-tray)</li>
			<li>Spare energy packs</li>
		</ul><br>
		<a href="#Contents">Contents</a>
		<h1><a name="Tools">Knowing your tools</a></h1>
		Every archaeologist has a plethora of tools at their disposal, but here's the important ones:<br>
		<ul>
			<li><b>Picks, pickaxes, and brushes</b> - don't underestimate the the smallest or largest in your arsenal, each one clears a different amount
				of the rockface so each one has a use.</li>
			<li><b>Measuring tape</b> - don't leave home without it, you can use it to measure the depth a rock face has been excavated to.</li>
			<li><b>GPS locator</b> - knowing where you are is the first step to not be lost.</li>
			<li><b>Core sampler</b> - use this to take core samples from rock faces, which you can then run to the lab for analysis.</li>
			<li><b>Depth scanner</b> - uses X-ray diffraction to locate anomalous densities in rock, indicating archaeological deposits or mineral veins.
				Comes with a handy reference log containing coordinates and time of each scan.</li>
			<li><b>Alden-Saraspova counter</b> - uses a patented application of Fourier Transform analysis to determine the difference between background and
				exotic radiation. Use it to determine how far you are from anomalous energy sources.</li>
			<li><b>Radio beacon locator</b> - leave a beacon at an item of interest, then track it down later with this handy gadget. Watch for interference from other
				devices though.</li>
			<li><b>Flashlight or portable light source</b> - Self explanatory, I hope.</li>
			<li><b>Environmental safety gear</b> - This one's dependent on the environment you're working in, but enclosed footwear and a pack of internals
				could save your life.</li>
			<li><b>Anomaly safety gear</b> - A biosealed and catalysis-resistant suit along with eye shielding, tinted hood, and non-reactive disposable gloves are
			the best kind of protection you can hope for from the errors our forebears may have unleashed.</li>
			<li><b>Personal defence weapon</b> - Never know what you'll find on the dig: pirates, natives, ancient guardians, carnivorous wildlife...
				it pays in blood to be prepared.</li>
		</ul><br>
		<a href="#Contents">Contents</a>
		<h1><a name="Find">Finding the dig</a></h1>
		Wouldn't be an archaeologist without their dig, but everyone has to start somewhere. Here's a basic procedure I go through when cataloguing a new planet:<br>
		<ul>
			<li><b>Get in touch with the locals</b> (in particular geologists, miners, and farmers) - Never know what's been turned up by accident, then left to
				gather dust on a shelf.</li>
			<li><b>Check the obvious areas first</b> - even if you're pressed for time, these ones are the generally easiest to search, and the most likely targets
				of your rivals.</li>
			<li><b>Do some prospecting</b> - the earth mother isn't in the habit of displaying her secrets to the world (although sometimes you get lucky).
				Drop a shaft and clear away a bit of surface rock here and there, you never know what might be lurking below the surface.</li>
			<li><b>Tips on unearthing a deposit</b> - How do you know when you're golden? Look for telltale white strata that looks strange or out of place, or if
				something has broken under your pick while you're digging. Your depth scanner is your best friend, but even it can't distinguish between
				ordinary minerals and ancient leavings, if in doubt then err on the side of caution.</li>
		</ul><br>
		<a href="#Contents">Contents</a>
		<h1><a name="Analyse">Analysing the contents of a dig</a></h1>
		You've found some unusual strata, but it's not all peaches from here. No archaeologist ever managed to pull a bone from the earth without doing thorough
		chemical analysis on every two meters of rock face nearby.<br>
		<ul>
			<li><b>Take core samples</b> - Grab a rock core for every 4m^2.</li>
			<li><b>Clear around any potential finds</b> - Clear away ordinary rock, leaving your prizes reachable in a clearly marked area.</li>
			<li><b>Haul off excess rock</b> - It's easy for a dig to get cluttered, and a neat archaeologist is a successful archaeologist.</li>
			<li><b>Don't be afraid to be cautious</b> - It's slower sometimes, but the extra time will be worth the payoff when you find an Exolitic relic.</li>
			<li><b>Chemical analysis</b> - I won't go into detail here, but the labwork is essential to any successful extraction. Marshal your core samples, and
				send them off to the labcoated geniuses.</li>
		</ul><br>
		<a href="#Contents">Contents</a>
		<h1><a name="Excavate">Extracting your first find</a></h1>
		<ul>
			<li><b>Scan the rock</b> - Use a depth scanner to determine the find's depth and clearance. DON'T FORGET THESE.</li>
			<li><b>Choose stasis field</b> - Chemical analysis on a core sample from the rock face will tell you which field is necessary to extract the find safely.</li>
			<li><b>Setup field gen</b> - Bolt it down, choose the field, check the charge, and activate it. If you forget it, you'll wish you hadn't when that priceless
				Uryom vase crumbles as it sees the light of day.</li>
			<li><b>FUNCTIONAL AND SAFE digging</b> - Dig into the rock until you've cleared away a depth equal to (the anomaly depth MINUS the clearance range). The find
				should come loose on it's own, but it will be in the midst of a chunk of rock. Use a welder or miniature excavation tool to clear away the excess.</li>
			<li><b>FANCY AND SPEEDY digging</b> - Dig into the rock until you've cleared away a depth equal to the anomaly depth, but without any of your strokes
				entering the clearance range.</li>
			<li><b>The big find</b> - Sometimes, you'll chance upon something big, both literally and figuratively. Giant statues and functioning remnants of Precursor
				technology are just as exciting, to the right buyers. If your digging leaves a large boulder behind, dig into it normally and see if anything's hidden
					inside.</li>
		</ul><br>
		<a href="#Contents">Contents</a>
	"}


/datum/codex_entry/guide/mass_spectrometry
	name = "Guide to Mass Spectrometry"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	lore_text = {"
		<h1><a name="Contents">Contents</a></h1>
		<ol>
			<li><a href="#Terms">A note on terms</a></li>
			<li><a href="#Analysis">Analysis progression</a></li>
			<li><a href="#Heat">Heat management</a></li>
			<li><a href="#Radiation">Ambient radiation</a></li>
		</ol>
		<br>
		<h1><a name="Terms">A note on terms</a></h1>
		<ul>
			<li><b>Mass spectrometry</b> - MS is the procedure used to measure and quantify the components of matter. The most prized tool in the field of
				'Materials analysis.'</li>
			<li><b>Radiometric dating</b> - MS applied using the right carrier reagents can be used to accurately determine the age of a sample.</li>
			<li><b>Dissonance ratio</b> - This is a pseudoarbitrary value indicating the overall presence of a particular element in a greater composite.
				It takes into account volume, density, molecular excitation and isotope spread.</li>
			<li><b>Vacuum seal integrity</b> - A reference to how close an airtight seal is to failure.</li>
		</ul><br>
		<a href="#Contents">Contents</a>
		<h1><a name="Analysis">Analysis progression</a></h1>
		Modern mass spectrometry requires constant attention from the diligent researcher in order to be successful. There are many different elements to juggle,
			and later chapters will delve into them. For the spectrometry assistant, the first thing you need to know is that the scanner wavelength is automatically
			calculated for you. Just tweak the settings and try to match it with the actual wavelength as closely as possible.<br>
		<br>
		<a href="#Contents">Contents</a>
		<h1><a name="Seal">Seal integrity</a></h1>
		In order to maintain sterile and environmentally static procedures, a special chamber is set up inside the spectrometer. It's protected by a proprietary vacuum seal
			produced by top tier industrial science. It will only last for a certain number of scans before failing outright, but it can be resealed through use of nanite paste.
			Unfortunately, it's susceptible to malforming under heat stress so exposing it to higher temperatures will cause it's operation life to drop significantly.<br>
		<br>
		<a href="#Contents">Contents</a>
		<h1><a name="Heat">Heat management</a></h1>
		The scanner relies on a gyro-rotational system that varies in speed and intensity. Over the course of an ordinary scan, the RPMs can change dramatically. Higher RPMs
			means greater heat generation, but is necessary for the ongoing continuation of the scan. To offset heat production, spectrometers have an inbuilt cooling system.
			Researchers can modify the flow rate of water to aid in dropping temperature as necessary, but are advised that frequent water replacements may be necessary
			depending on coolant purity. Other substances may be viable substitutes, but nowhere near as effective as water itself.<br>
		<br>
		<a href="#Contents">Contents</a>
		<h1><a name="Radiation">Ambient radiation</a></h1>
		Researchers are warned that while operational, mass spectrometers emit period bursts of radiation and are thus advised to wear protective gear. In the event of
			radiation spikes, there is also a special shield that can be lowered to block emissions. Lowering this, however, will have the effect of blocking the scanner
			so use it sparingly.<br>
		<br>
		<a href="#Contents">Contents</a>
	"}

/datum/codex_entry/guide/engineering
	name = "Guide to Engineering"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE

/datum/codex_entry/guide/construction
	name = "Guide to Construction"

/datum/codex_entry/guide/fusion
	name = "Guide to Fusion Reactors"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE

/datum/codex_entry/guide/hacking
	name = "Guide to Hacking"
	available_to_map_tech_level = MAP_TECH_LEVEL_SPACE
	associated_strings = list("hacking")
	mechanics_text = "Airlocks, vending machines, and various other machinery can be hacked by opening them up and fiddling with the wires. \
	While it might sound like a unlawful deed (and it usually is) this process is also performed by engineers, usually to fix said criminal deeds. \
	Hacking also benefits from the <span codexlink='Electrical Engineering (skill)'>Electrical Engineering</span> skill: a low skill may cause wires to tangle, and a high enough skill will let you examine wires to see what they do. \
	<BR>Hacking makes use of several items: \
	<ul><li>a <span codexlink='" + TOOL_CODEX_SCREWDRIVER + "'>screwdriver</span>, for opening maintenance panels.</li> \
	<li>a <span codexlink='" + TOOL_CODEX_MULTITOOL + "'>multitool</span>, for pulsing wires (optional for many tasks, but very useful)</li> \
	<li><span codexlink='" + TOOL_CODEX_WIRECUTTERS + "'>wirecutters</span>, for cutting wires</li> \
	<li>insulated gloves, to prevent electrocution (optional but highly recommended)</li> \
	<li>a <span codexlink='" + TOOL_CODEX_CROWBAR + "'>crowbar</span>, if you're hacking a door to open it.</li></ul> \
	<BR>The first step to most hacking procedures is to use the screwdriver to open a maintenance panel and access the wiring. \
	After, you can click on the machine to view the wires. \
	You then use the multitool to pulse the wires, and in response some of the displayed information may change, causing certain effects to occur or allowing for certain benefits. \
	If you don't have a multitool, you can cut the wires. \
	Pulsing tends to cause temporary changes or toggles something, whereas cutting a wire is usually longer lasting, but this is not always the case. \
	Note that the corresponding wires and effects are randomized between rounds of the game. \
	You can also attach a signaler to pulse wires remotely."
	antag_text = "To avoid suspicion or accidents, practice quietly somewhere out of the way and learn the wires you need before doing it for real."

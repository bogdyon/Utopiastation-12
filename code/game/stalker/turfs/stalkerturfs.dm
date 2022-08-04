#define NORTH_EDGING	"north"
#define SOUTH_EDGING	"south"
#define EAST_EDGING		"east"
#define WEST_EDGING		"west"
var/slowdown
var/environment_type = null
var/icon_plating = null
var/dug = null
var/overlay_priority = null

/turf/simulated/floor/plating/asteroid/snow/lite
	name = "snow"
	desc = "�������� ��������."
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"

	temperature = 293



/obj/structure/grille/stalker
	desc = "�������, ������� �������� �����."
	name = "fence"
	icon = 'icons/stalker/lohweb/structures.dmi'
	icon_state = "bars"
	density = 1
	anchored = 1
	layer = 2.9
	health = 1000

/obj/structure/grille/stalker/ex_act(severity, target)
	return

/obj/structure/grille/stalker/attack_hand(mob/living/user)
	user.do_attack_animation(src)
	return

/obj/structure/grille/stalker/attack_animal(var/mob/living/simple_animal/M)
	M.do_attack_animation(src)
	return

/obj/structure/grille/stalker/bullet_act(var/obj/item/projectile/Proj)
	if(!Proj)
		return


/obj/structure/grille/stalker/attackby(obj/item/weapon/W, mob/user, params)
	return

/obj/structure/grille/hitby(AM as mob|obj)
	..()
	return

/obj/structure/grille/stalker/wood
	desc = "�������, ������ ���������� �����."
	icon_state = "zabor_horizontal1"
	density = 1
	opacity = 0

/obj/structure/grille/stalker/beton
	icon = 'icons/stalker/beton_zabor.dmi'
	desc = "������� �������."
	icon_state = "1"
	density = 1
	opacity = 0

/obj/structure/grille/stalker/beton/green
	icon = 'icons/stalker/green_zabor.dmi'
	desc = "������� �����. �����, ��� �����."
	icon_state = "1"
	layer = 6.1

obj/structure/grille/stalker/beton/CanPass(atom/movable/mover, turf/target, height=0)
	if(height==0) return 1

	else
		if(istype(mover, /obj/item/projectile) && density)
			return prob(0)
		else
			return !density

/turf/simulated/floor/stalker
	name = "stalker turf"
	icon = 'icons/stalker/grass.dmi'

/turf/simulated/floor/stalker/floor
	name = "Grass"
	icon = 'icons/stalker/grass.dmi'
	icon_state = "grass1"
	layer = TURF_LAYER

/turf/simulated/floor/stalker/floor/digable


/turf/simulated/floor/stalker/floor/digable/grass
	icon = 'icons/stalker/zemlya.dmi'
	icon_state = "grass1"

/turf/simulated/floor/stalker/floor/digable/grass/dump
	icon = 'icons/stalker/zemlya.dmi'
	icon_state = "dump_grass1"
/*
/turf/simulated/floor/stalker/floor/digable/grass/dump/New()
	icon_state = "dump_grass[rand(1, 3)]"
*/
/turf/simulated/floor/stalker/floor/digable/gryaz_rocky
	icon_state = "gryaz_rocky1"

/turf/simulated/floor/stalker/floor/digable/gryaz_rocky/New()
	icon_state = "gryaz_rocky[rand(1, 3)]"

/turf/simulated/floor/stalker/floor/sidor
	name = "floor"
	icon = 'icons/turf/beton.dmi'
	icon_state = "sidorpol"

/obj/machinery/door/unpowered/metro
	icon = 'icons/stalker/lohweb/door_cave.dmi'
	icon_state = "door1"

/obj/machinery/door/unpowered/metro/broken
	icon = 'icons/stalker/lohweb/door_cave.dmi'
	icon_state = "xdoor1"
	opacity = 0

/obj/machinery/door/unpowered/metro/prison
	icon = 'icons/stalker/lohweb/door_prison.dmi'
	icon_state = "door1"
	opacity = 0

/obj/machinery/door/unpowered/metro/woodglass
	icon = 'icons/stalker/some_stuff/key_door.dmi'
	icon_state = "door1"
	opacity = 0

/obj/machinery/door/unpowered/metro/woodd
	icon = 'icons/stalker/some_stuff/wooddoor.dmi'
	icon_state = "door1"

/turf/simulated/floor/stalker/floor/asphalt
	name = "road"
	icon = 'icons/stalker/Prishtina/asphalt.dmi'
	icon_state = "road1"
	layer = 2


var/global/list/AsphaltEdgeCache

/turf/simulated/floor/stalker/floor/asphalt/New()
	icon_state = "road[rand(1, 3)]"
	if(!AsphaltEdgeCache || !AsphaltEdgeCache.len)
		AsphaltEdgeCache = list()
		AsphaltEdgeCache.len = 10
		AsphaltEdgeCache[NORTH] = image('icons/stalker/Prishtina/asphalt.dmi', "roadn", layer = 2.01)
		AsphaltEdgeCache[SOUTH] = image('icons/stalker/Prishtina/asphalt.dmi', "roads", layer = 2.01)
		AsphaltEdgeCache[EAST] = image('icons/stalker/Prishtina/asphalt.dmi', "roade", layer = 2.01)
		AsphaltEdgeCache[WEST] = image('icons/stalker/Prishtina/asphalt.dmi', "roadw", layer = 2.01)

	spawn(1)
		var/turf/T
		for(var/i = 0, i <= 3, i++)
			if(!get_step(src, 2**i))
				continue
				T = get_step(src, 2**i)
				if(T)
					T.overlays += AsphaltEdgeCache[2**i]
	return

/turf/simulated/floor/stalker/floor/tropa
	name = "road"
	icon = 'icons/stalker/tropa.dmi'
	icon_state = "tropa"
	layer = 2


var/global/list/TropaEdgeCache

/turf/simulated/floor/stalker/floor/tropa/New()
	if(!TropaEdgeCache || !TropaEdgeCache.len)
		TropaEdgeCache = list()
		TropaEdgeCache.len = 10
		TropaEdgeCache[NORTH] = image('icons/stalker/tropa.dmi', "tropa_side_n", layer = 2.01)
		TropaEdgeCache[SOUTH] = image('icons/stalker/tropa.dmi', "tropa_side_s", layer = 2.01)
		TropaEdgeCache[EAST] = image('icons/stalker/tropa.dmi', "tropa_side_e", layer = 2.01)
		TropaEdgeCache[WEST] = image('icons/stalker/tropa.dmi', "tropa_side_w", layer = 2.01)

	spawn(1)
		var/turf/T
		for(var/i = 0, i <= 3, i++)
			if(!get_step(src, 2**i))
				continue
				T = get_step(src, 2**i)
				if(T)
					T.overlays += TropaEdgeCache[2**i]
	return

/turf/simulated/floor/stalker/floor/road
	name = "road"
	icon = 'icons/stalker/building_road.dmi'
	icon_state = "road2"
	layer = 1


var/global/list/WhiteRoadCache

/turf/simulated/floor/stalker/floor/road/New()
	switch(rand(1, 100))
		if(1 to 65)
			icon_state = "road2"
		if(66 to 85)
			icon_state = "road1"
		if(86 to 90)
			icon_state = "road3"
		if(91 to 95)
			icon_state = "road4"
		if(96 to 100)
			icon_state = "road5"
	spawn(1)
	for(var/i = 0, i <= 3, i++)
	return

/turf/simulated/floor/stalker/floor/gryaz
	name = "dirt"
	icon = 'icons/stalker/zemlya.dmi'
	icon_state = "gryaz1"
	layer = 1


var/global/list/GryazEdgeCache

/turf/simulated/floor/stalker/floor/gryaz/New()
	icon_state = "gryaz[rand(1, 3)]"
	if(!GryazEdgeCache || !GryazEdgeCache.len)
		GryazEdgeCache = list()
		GryazEdgeCache.len = 10
		GryazEdgeCache[NORTH] = image('icons/stalker/zemlya.dmi', "gryaz_side_n", layer = 2.01)
		GryazEdgeCache[SOUTH] = image('icons/stalker/zemlya.dmi', "gryaz_side_s", layer = 2.01)
		GryazEdgeCache[EAST] = image('icons/stalker/zemlya.dmi', "gryaz_side_e", layer = 2.01)
		GryazEdgeCache[WEST] = image('icons/stalker/zemlya.dmi', "gryaz_side_w", layer = 2.01)

	spawn(1)
		var/turf/T
		for(var/i = 0, i <= 3, i++)
			if(!get_step(src, 2**i))
				continue
				T = get_step(src, 2**i)
				if(T)
					T.overlays += GryazEdgeCache[2**i]
	return

/turf/simulated/floor/stalker/floor/gryaz/gryaz2
	icon_state = "gryaz2"

/turf/simulated/floor/stalker/floor/gryaz/gryaz3
	icon_state = "gryaz3"

/obj/structure/stalker/rails
	name = "rails"
	icon = 'icons/stalker/rails.dmi'
	icon_state = "sp"
	layer = 1
	anchored = 1
	density = 0
	opacity = 0

/turf/simulated/floor/stalker/floor/plasteel
	name = "floor"
	icon = 'icons/stalker/floor.dmi'

/turf/simulated/floor/stalker/floor/plasteel/plita
	icon_state = "plita1"

/turf/simulated/floor/stalker/floor/plasteel/plita/New()
	icon_state = "plita[rand(1, 4)]"

/turf/simulated/floor/stalker/floor/plasteel/plitochka
	icon_state = "plitka1"

/turf/simulated/floor/stalker/floor/plasteel/plitochka/New()
	icon_state = "plitka[rand(1, 7)]"

/turf/simulated/floor/stalker/floor/plasteel/plitka
	icon_state = "plitka_old1"

/turf/simulated/floor/stalker/floor/plasteel/plitka/New()
	icon_state = "plitka_old[rand(1, 8)]"

/turf/simulated/floor/stalker/floor/water
	name = "water"
	icon = 'icons/stalker/water.dmi'
	icon_state = "water"
	layer = TURF_LAYER

	var/busy = 0

/turf/simulated/floor/stalker/floor/water/attack_hand(mob/living/user)
	if(!user || !istype(user))
		return
	if(!iscarbon(user))
		return
	if(!Adjacent(user))
		return

	if(busy)
		user << "<span class='notice'>Someone's already washing here.</span>"
		return
	var/selected_area = parse_zone(user.zone_sel.selecting)
	var/washing_face = 0
	if(selected_area in list("head", "mouth", "eyes"))
		washing_face = 1
	user.visible_message("<span class='notice'>[user] start washing their [washing_face ? "face" : "hands"]...</span>", \
						"<span class='notice'>You start washing your [washing_face ? "face" : "hands"]...</span>")
	busy = 1

	if(!do_after(user, 40, target = src))
		busy = 0
		return

	busy = 0

	user.visible_message("<span class='notice'>[user] washes their [washing_face ? "face" : "hands"] using [src].</span>", \
						"<span class='notice'>You wash your [washing_face ? "face" : "hands"] using [src].</span>")
	if(washing_face)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.lip_style = null //Washes off lipstick
			H.regenerate_icons()
		user.drowsyness -= rand(2,3) //Washing your face wakes you up if you're falling asleep
		user.drowsyness = Clamp(user.drowsyness, 0, INFINITY)
	else
		user.clean_blood()


/turf/simulated/floor/stalker/floor/water/attackby(obj/item/O, mob/user, params)
	if(busy)
		user << "<span class='warning'>Someone's already washing here!</span>"
		return

	if(istype(O, /obj/item/mop))
		O.reagents.add_reagent("water", 5)
		user << "<span class='notice'>You wet [O] in [src].</span>"
		playsound(loc, 'sound/effects/slosh.ogg', 25, 1)

	var/obj/item/I = O
	if(!I || !istype(I))
		return

	user << "<span class='notice'>You start washing [I]...</span>"
	busy = 1
	if(!do_after(user, 40, target = src))
		busy = 0
		return
	busy = 0
	O.clean_blood()
	user.visible_message("<span class='notice'>[user] washes [I] using [src].</span>", \
						"<span class='notice'>You wash [I] using [src].</span>")

/turf/simulated/floor/stalker/floor/water/Entered(atom/movable/A)
	..()
	if(istype(A, /mob/living))
		if(istype(A, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = A
			if(H.shoes)
				H.shoes.clean_blood()
			if(H.fire_stacks)
				H.fire_stacks = 0
				H.ExtinguishMob()

/turf/simulated/floor/stalker/floor/water/Exited(atom/movable/A)
	..()
	if(istype(A, /mob/living))
		flick("water_splash_movement", src)

var/global/list/WaterEdgeCache

/turf/simulated/floor/stalker/floor/water/New()
	if(!WaterEdgeCache || !WaterEdgeCache.len)
		WaterEdgeCache = list()
		WaterEdgeCache.len = 10
		WaterEdgeCache[NORTH] = image('icons/stalker/water.dmi', "water_north", layer = 2.01)
		WaterEdgeCache[SOUTH] = image('icons/stalker/water.dmi', "water_south", layer = 2.01)
		WaterEdgeCache[EAST] = image('icons/stalker/water.dmi', "water_east", layer = 2.01)
		WaterEdgeCache[WEST] = image('icons/stalker/water.dmi', "water_west", layer = 2.01)

	spawn(1)
		var/turf/T
		for(var/i = 0, i <= 3, i++)
			if(!get_step(src, 2**i))
				continue
				T = get_step(src, 2**i)
				if(T)
					T.overlays += WaterEdgeCache[2**i]
	return

/turf/simulated/floor/stalker/floor/wood
	icon = 'icons/stalker/floor.dmi'
	name = "floor"

/turf/simulated/floor/stalker/floor/wood/brown
	icon_state = "wooden_floor"

/turf/simulated/floor/stalker/floor/wood/grey
	icon_state = "wooden_floor2"

/turf/simulated/floor/stalker/floor/wood/black
	icon_state = "wooden_floor3"

/turf/simulated/floor/stalker/floor/wood/oldgor
	icon_state = "wood1"

/turf/simulated/floor/stalker/floor/wood/oldvert
	icon_state = "woodd1"

/turf/simulated/floor/stalker/floor/metro
	icon = 'icons/stalker/floor.dmi'
	icon_state = "bf25"
	name = "floor"

/turf/simulated/floor/stalker/floor/metro/v2
	icon = 'icons/stalker/floor.dmi'
	icon_state = "F74"

/turf/simulated/floor/stalker/floor/metro/v3
	icon = 'icons/stalker/floor.dmi'
	icon_state = "23323"

/turf/simulated/floor/stalker/floor/metro/v4
	icon = 'icons/stalker/floor.dmi'
	icon_state = "snf23"

/turf/simulated/floor/stalker/floor/metro/v5
	icon = 'icons/stalker/floor.dmi'
	icon_state = "nf24"

/turf/simulated/floor/stalker/floor/metro/v6
	icon = 'icons/stalker/floor.dmi'
	icon_state = "1"

/turf/simulated/floor/stalker/floor/metro/v7
	icon = 'icons/stalker/floor.dmi'
	icon_state = "surgery"

/turf/simulated/floor/stalker/floor/metro/v8
	icon = 'icons/stalker/floor.dmi'
	icon_state = "npolar2"

/turf/simulated/floor/stalker/floor/metro/v9
	icon = 'icons/stalker/floor.dmi'
	icon_state = "wtf"

/turf/simulated/floor/stalker/floor/metro/v10
	icon = 'icons/stalker/floor.dmi'
	icon_state = "npolar"

/turf/simulated/floor/stalker/floor/metro/v11
	icon = 'icons/stalker/floor.dmi'
	icon_state = "nfloorz"

/turf/simulated/floor/stalker/floor/metro/open
	icon = 'icons/stalker/floor.dmi'
	icon_state = "openspace"

/turf/simulated/floor/stalker/floor/metro/v12
	icon = 'icons/stalker/metro-2/Rails.dmi'
	icon_state = "rail_straight"

/turf/simulated/floor/stalker/floor/metro/v13
	icon = 'icons/stalker/metro-2/railroads.dmi'
	icon_state = "railroad"

/turf/simulated/floor/stalker/floor/metro/v18
	icon = 'icons/stalker/lohweb/floors.dmi'
	icon_state = "bfloorz"

/turf/simulated/floor/stalker/floor/metro/v19
	icon = 'icons/stalker/lohweb/floors.dmi'
	icon_state = "polar"

/turf/simulated/floor/stalker/floor/metro/rails/v14
	icon = 'icons/stalker/metro-2/railroads.dmi'
	icon_state = "railroad_left1"

/turf/simulated/floor/stalker/floor/metro/rails/v14/New()
	icon_state = "railroad_left[rand(1, 4)]"

/turf/simulated/floor/stalker/floor/metro/rails/v15
	icon = 'icons/stalker/metro-2/railroads.dmi'
	icon_state = "railroad_right1"

/turf/simulated/floor/stalker/floor/metro/rails/v15/New()
	icon_state = "railroad_right[rand(1, 4)]"

/turf/simulated/floor/stalker/floor/metro/rails/v16
	icon = 'icons/stalker/metro-2/railroads.dmi'
	icon_state = "railroad_south1"

/turf/simulated/floor/stalker/floor/metro/rails/v16/New()
	icon_state = "railroad_south[rand(1, 4)]"

/turf/simulated/floor/stalker/floor/metro/rails/v17
	icon = 'icons/stalker/metro-2/railroads.dmi'
	icon_state = "railroad_north1"

/turf/simulated/floor/stalker/floor/metro/rails/v17/New()
	icon_state = "railroad_north[rand(1, 4)]"

/turf/simulated/floor/stalker/floor/agroprom/beton
	name = "floor"
	icon = 'icons/stalker/pol_agroprom.dmi'
	icon_state = "beton1"

/turf/simulated/floor/stalker/floor/agroprom/beton/New()
	icon_state = "beton[rand(1, 4)]"

/turf/simulated/floor/stalker/floor/agroprom/gryaz
	name = "dirt"
	icon = 'icons/stalker/pol_agroprom.dmi'
	icon_state = "gryaz1"

/turf/simulated/floor/stalker/floor/agroprom/gryaz/New()
	icon_state = "gryaz[rand(1, 11)]"

/turf/simulated/floor/stalker/floor/lattice
	name = "lattice"
	icon = 'icons/stalker/floor.dmi'
	icon_state = "lattice_new"

/*
/turf/simulated/floor/stalker/floor/lattice/New()
	icon_state = "lattice[rand(1, 4)]"
*/

/turf/simulated/floor/stalker/floor/plasteel/plita/orange
	icon_state = "plita_orange"
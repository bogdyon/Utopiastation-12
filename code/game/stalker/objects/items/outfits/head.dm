/*
/obj/item/clothing/head/New()
	..()
	sleep(5)
	if(nvg)
		if(nvg.colour_matrix == NIGHTVISION_MATRIX_I)
			modifications += "visor"
		else if(nvg.colour_matrix == NIGHTVISION_MATRIX_II)
			modifications += "visor"
*/
/obj/item/clothing/head/steel
	name = "Steel helmet"
	desc = "����� �� ������, ������� ������ �����, ����� ���� ���� ��������� �� ��� ��������. �� ��� ������ ����������� �� ����������� ����, �� �� ������������ �������� ����� ��� ������� �� ������."
	eng_desc = "Steel helmet made of old rusty steel. You look nazi wearing it. Protects your head but won't hold lots of bullets"
	icon_state = "steelhelmet"
	item_state = "steelhelmet"
	armor = list(melee = 25, bullet = 40, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, psy = 5)
	flags = BLOCKHAIR
	flags_cover = 0
	unacidable = 1
	durability = 40
	modifications = list("material_head" = 0)

/obj/item/clothing/head/mob_can_equip(mob/M, slot, disable_warning = 0)
	if(!iscarbon(M))
		return ..()

	var/mob/living/carbon/C = M

	if(slot != slot_head)
		return ..()

	if(!(flags_cover & HEADCOVERSMOUTH))
		return ..()

	if(!(C.wear_mask) || !(istype(C.wear_mask, /obj/item/clothing/mask/gas)))
		return ..()

	return 0

/obj/item/clothing/head/tacticalhelmet
	name = "Tactical helmet"
	desc = "������������� ������� ������������ �����, �������� �����-���� ����������. ������������ ��&#255; ����������&#255; ��������� ������������&#255; ������� ����������� ����������� ���������� ��� ��������� ��������������� ����������� �������. ���������&#255; ������� ������������, ����� ������� ������������ ���������� �������, ������������ � �������� ������� ������&#255; ������� ��������&#255;."
	eng_desc = "A Western model of a tactical helmet that lacks ca	mouflage. It is not known how it made its way into the Zone. The helmet is designed to provide a squad leader with strategic superiority over the enemy via its many scanners and satellite communications devices, which have not been installed in this particular helmet. Comes with multi-layered Kevlar protection and armored elements to protect electronic components. Includes a respirator and a nightvision device."
	icon_state = "hardhat0_tactical"
	item_state = "hardhat0_tactical"
	item_color = "tactical"
	flags = BLOCKHAIR|BLOCKFACIALHAIR
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	armor = list(melee = 50, bullet = 60, laser = 0,energy = 30, bomb = 0, bio = 30, rad = 20, psy = 10)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	unacidable = 1
	durability = 300
	//�����������//
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 1)

/obj/item/clothing/head/tacticalhelmet/New()
	nvg = new /obj/item/nightvision(src)
	..()

/obj/item/clothing/head/hardhat/tactical/light
	name = "Light tactical helmet"
	desc = "������������� ������� ������������ �����, �������� �����-���� ����������. ������������ ��&#255; ����������&#255; ������ �������� �������� ������� ������. ���������&#255; ������� ������������, ����� ������� ������������ ���������� �������, �� ���������� � ��� �����������."
	eng_desc = "A Western model of a tactical helmet that lacks camouflage. It is not known how it made its way into the Zone. The helmet is designed to provide a squad leader with strategic superiority over the enemy via its many scanners and satellite communications devices, which have not been installed in this particular helmet. Comes with multi-layered Kevlar protection and armored elements to protect electronic components."
	icon_state = "hardhat0_lighttactical"
	item_state = "hardhat0_lighttactical"
	item_color = "lighttactical"
	flags = BLOCKHAIR
	flags_inv = HIDEEARS|HIDEEYES
	action_button_name = "Toggle Light"
	armor = list(melee = 35, bullet = 50, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, psy = 5)
	brightness_on = 2 //luminosity when on
	flags_cover = HEADCOVERSEYES
	unacidable = 1
	durability = 200
	//�����������//
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 0)

/obj/item/clothing/head/hardhat/tactical/light/New()
	..()
	return

/obj/item/clothing/head/assaultmerc
	name = "Mercenary helmet"
	desc = "��������� ����� ���� � ������-����� ������������� ������, ���&#255; �� ���������� - ������������ ������������. ����������� ������� ������ �������� ����, � ��� ���� �������, ����������� �������� ��������&#255;. ������� �������&#255; ��&#255;��."
	icon_state = "assaultmerc"
	item_state = "assaultmerc"
	flags = BLOCKHAIR|BLOCKFACIALHAIR
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	armor = list(melee = 50, bullet = 75, laser = 25,energy = 50, bomb = 0, bio = 0, rad = 0, psy = 5)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	unacidable = 1
	durability = 250
	//�����������//
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 0)

/obj/item/clothing/head/gopcap
	name = "�ap"
	desc = "�����&#255; � ������ ������� �����."
	icon_state = "gopcap"
	item_state = "gopcap"
	flags = BLOCKHAIR

/obj/item/clothing/head/soft/jacknoircap
	name = "�ap"
	desc = "����������&#255; ����� ���������. ���-���!"
	icon_state = "jacknoirsoft"
	item_color = "jacknoir"
	item_state = "greysoft"

/obj/item/clothing/head/spheram
	name = "Sphera M12"
	desc = "���������� ������ ����������-��������� ���� � ��������� ��&#255; �������� �������������� � �����������. ������ �������&#255;���&#255; � ��������� � ������������� ������ ��3 ��&#255; ��������. ���������� �����&#255;��� � ���� ��������&#255; ����������� � ����������� ������� ������� ������&#255;, � ����� ������� ������ ������. ������������� ����������� ��������� �����������."
	eng_desc = "An aluminum/titanium helmet with a cloth exterior that comes with pockets for additional steel armor pieces and an armor face mask. Sphere M12 is normally used as part of a combination that includes PSZ series Spetsnaz body armor. Quite popular in the Zone thanks to its respirator and built-in first generation night vision device, as well as providing the maximum head protection possible. Comes with electronics slots."
	icon_state = "sphera"
	flags = BLOCKHAIR|BLOCKFACIALHAIR
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	armor = list(melee = 60, bullet = 65, laser = 0,energy = 35, bomb = 0, bio = 30, rad = 30, psy = 20)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	unacidable = 1
	durability = 400
	//�����������//
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 0)

/obj/item/clothing/head/spheram/New()
	nvg = new /obj/item/nightvision(src)
	..()

/obj/item/clothing/head/skathelmet
	name = "SKAT-M9"
	desc = "���������� ������ ����������-��������� ���� � ��������� ��&#255; �������� �������������� � �����������. ������ �������&#255;���&#255; � ��������� � ������������� ������ ��3 ��&#255; ��������. ���������� �����&#255;��� � ���� ��������&#255; ����������� � ����������� ������� ������� ������&#255;, � ����� ������� ������ ������."
	eng_desc = "An aluminum/titanium helmet with a cloth exterior that comes with pockets for additional steel armor pieces and an armor face mask. Sphere M12 is normally used as part of a combination that includes PSZ series Spetsnaz body armor. Quite popular in the Zone thanks to its respirator and built-in first generation night vision device, as well as providing the maximum head protection possible. Comes with electronics slots."
	icon_state = "helmet_skat"
	flags = BLOCKHAIR|BLOCKFACIALHAIR
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	armor = list(melee = 75, bullet = 75, laser = 60,burn = 70, bomb = 70, bio = 50, rad = 40, electro = 70, psy = 10)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	unacidable = 1
	durability = 400
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 1)

/obj/item/clothing/head/skathelmet/New()
	nvg = new /obj/item/nightvision(src)
	..()

/obj/item/clothing/head/petrovichhelmet
	name = "SKOT-M777"
	desc = "���������� �������� ����������-��������� ���� � ��������� ��&#255; ������ � ����������. ������ �������&#255;���&#255; � ��������� � ������. ������������ �����&#255;��� � ���� ��������&#255; ����������� ���������."
	icon_state = "helmet_skot"
	flags = BLOCKHAIR|BLOCKFACIALHAIR
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	armor = list(melee = 75, bullet = 75, laser = 60,burn = 70, bomb = 70, bio = 50, rad = 40, electro = 70, psy = 50)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	unacidable = 1
	durability = 400
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 0)

/obj/item/clothing/head/beret_ua
	name = "military beret"
	desc = "����������� ����� � ����������� ������� ����������� �����."
	icon_state = "beret_ua"
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	strip_delay = 80
/*
/obj/item/clothing/mask/gas/New()
	..()
	sleep(5)
	if(nvg)
		if(nvg.colour_matrix == NIGHTVISION_MATRIX_I)
			modifications += "visor"
		else if(nvg.colour_matrix == NIGHTVISION_MATRIX_II)
			modifications += "visor"
*/
/obj/item/clothing/mask/gas/stalker
	name = "gas mask"
	desc = "����������� ����������, ��������������� ��&#255; ���������� �� ������� ������������� ���� � ������&#255;���� �������. ������ �����������&#255; ��� ���������, ��� � ���������� ���� ����������� ����� ����� �������������� �������������. �� ������� ������� �� ����, �������� � ������������ �����������."
	eng_desc = "A regular plastic and rubber gas mask, used for filtering air for radioactive particles and poisonous substances. Widely used by rookies and veterans of all factions due to its universal functionality. Does not provide any physical protection."
	icon_state = "gasmasknew"
	item_state = "gasmasknew"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH
	flags = BLOCKHAIR|BLOCKFACIALHAIR
	armor = list(melee = 5, bullet = 0, laser = 30,burn = 30, bomb = 0, bio = 20, rad = 60, electro = 30, psy = 0)
	burn_state = FIRE_PROOF
	unacidable = 1
	durability = 400
	//�����������//
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 0)

/obj/item/clothing/mask/gas/stalker/mercenary
	name = "gas mask"
	desc = "����������� ����������, ��������������� ��&#255; ���������� �� ������� ������������� ���� � ������&#255;���� �������. ������ �����������&#255; ������� ����������� '��������'. �� ������� ������� �� ����, �������� � ������������ �����������."
	eng_desc = "A regular plastic and rubber gas mask, used for filtering air for radioactive particles and poisonous substances. Widely used by mercenaries. Does not provide any physical protection."
	icon_state = "mercenary_gasmask"
	item_state = "mercenary_gasmask"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH
	flags = BLOCKFACIALHAIR
	armor = list(melee = 5, bullet = 0, laser = 30,burn = 30, bomb = 0, bio = 20, rad = 60, electro = 30, psy = 0)
	burn_state = FIRE_PROOF
	unacidable = 1
	durability = 400
	//�����������//
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 0)

/obj/item/clothing/head/metro/steel
	name = "Steel helmet"
	desc = "����� �� ������, ������� ������ �����, ����� ���� ���� ��������� �� ��� ��������. �� ��� ������ ����������� �� ����������� ����, �� �� ������������ �������� ����� ��� ������� �� ������."
	eng_desc = "Steel helmet made of old rusty steel. You look nazi wearing it. Protects your head but won't hold lots of bullets"
	icon_state = "stahlhelm"
	item_state = "stahlhelm"
	armor = list(melee = 25, bullet = 50, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, psy = 5)
	//flags = BLOCKHAIR
	flags_cover = 0
	unacidable = 1
	durability = 60
	modifications = list("material_head" = 0)

/obj/item/clothing/head/metro/moth
	name = "Moth"
	desc = "�������&#255;, �� ����&#255; ����. ����� �� ���� ����� ���������."
	eng_desc = "Moth"
	icon_state = "moth"
	item_state = "moth"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, psy = 100)
	//flags = BLOCKHAIR
	flags_cover = 0
	unacidable = 1
	durability = 200
	modifications = list("material_head" = 0)

/obj/item/clothing/mask/gas/metro
	name = "gas mask"
	desc = "����������� ����������, ��������������� ��&#255; ���������� �� ������� ������������� ���� � ������&#255;���� �������. ������ �����������&#255; �������� �����&#255;��. �� ������� ������� �� ����, �������� � ������������ �����������."
	eng_desc = "A regular plastic and rubber gas mask, used for filtering air for radioactive particles and poisonous substances. Widely used by rookies and veterans of all factions due to its universal functionality. Does not provide any physical protection."
	icon_state = "glass_mask"
	item_state = "glass_mask"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH
	flags = BLOCKFACIALHAIR
	armor = list(melee = 10, bullet = 0, laser = 0,burn = 30, bomb = 0, bio = 30, rad = 60, electro = 0, psy = 0)
	burn_state = FIRE_PROOF
	unacidable = 1
	durability = 400
	//�����������//
	modifications = list("padding_head" = 0, "material_head" = 0, "visor_head" = 0)

/obj/item/clothing/head/metro/tactical
	name = "Tactical helmet"
	desc = "������� ������������� ����. ������, ������� ��������, �� ������������ �����. � ��� ����&#255; ���� �� ����� �����&#255;������, �� ������ �����������&#255; � �������� ����-���������� ���."
	eng_desc = "Tactical helmet"
	icon_state = "tactical_helmet"
	item_state = "tactical_helmet"
	armor = list(melee = 40, bullet = 65, laser = 0,energy = 0, bomb = 30, bio = 0, rad = 0, psy = 10)
	flags = BLOCKHAIR
	flags_cover = 0
	unacidable = 1
	durability = 80
	modifications = list("material_head" = 0)
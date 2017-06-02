SCHEMA.name = "Witcher RolePlay"
SCHEMA.introName = "Witcher Roleplay"
SCHEMA.author = "AleXXX_007"
SCHEMA.descs = {
	"Что-то кончается, что-то начинается...",
	"Строить великие планы легче, чем воплощать их в жизнь.",
	"Не стоит умирать за идею, особенно если в её основе лежит ненависть.",
	"С опытом приходит мастерство.",
	"Избыток власти убивает.",
	"Жаждешь справедливости — найми ведьмака.",
	"Невозможно также остаться чистым, валяясь в крови.",
	"Безопасность государства не имеет ничего общего со справедливостью.",
	"…если цель привлекает, средство должно найтись.",
	"Битву закончит смерть, всё остальное лишь перерыв в битве.",
	"Деньги открывают любые двери.",
	"Никогда не выпадает вторая оказия создать первое впечатление.",
	"Войны ведут по двум причинам. Одна из них - власть, другая - деньги.",
	"Жизнь - бесценный дар, и ее надлежит хранить.",
	"Не стоит путать небо со звездами, отраженными ночью в поверхности пруда.",
	"Любовь смеется над рассудком. И в этом ее притягательная сила и прелесть.",
	"Изменения политического режима не могут служить оправданием вандализма.",
	"Абракадабра, чары-мары, фокус-покус...",
	"Каэд-мил, блёде дхойно... Фокус-покус... Чары-мары... Арс Блатанна...",
	"Гвинт напоминает политику. Только честнее.",
	"Сплошные раритеты по доступным це... Ох, сука! Ты меня не видел!",
	"С нами лучше не балуй, лишь бы цел остался..."
}

nut.command.add("getpos", {
	onRun = function(client, arguments)
		client:ChatPrint(tostring(client:GetPos()))
	end
})

function SCHEMA:CanPlayerUseBusiness(client, uniqueID)
	if (client:IsAdmin()) then
		return true
	end
	return false
end

function SCHEMA:OnCharCreated(client, character, data)
	local tempos = {
	"619.288025 3939.768555 -511.950806",
	"526.090149 4039.658203 -511.930176",
	"4613.983398 5273.305176 -493.663422",
	"4888.435547 5319.496094 -501.846130"
	}
	local nilfpos = {
	"12209.057617 -10953.781250 -15.038702",
	"10620.695313 -10845.915039 -14.694324",
	"11716.962891 -12746.953125 -9.541359"
	}
	local nelidpos = {
	"-6527.997559 4575.791016 -511.968750",
	"-6928.993652 4379.458008 -512.319519",
	"-10246.228516 4450.937012 -511.430725"
	}
	local bibpos = {
	"-6875.145508 -6996.525391 -511.968750",
	"-5986.125488 -8129.852539 -499.596222",
	"-10386.187500 -6598.321777 -510.114319"
	}
	local randompos = {
	"7562.795898 -10013.430664 -512.057556",
	"6677.879395 -6849.084961 -531.120544",
	"11277.405273 -534.208435 -67.375763",
	"4366.059082 -2314.692139 -513.059998"
	}
	local position = {
	["Майенна (Темерия)"] = {tonumber(table.Random(tempos)), nil, game.GetMap()},
	["Подворенга (Нильфгаард)"] = {tonumber(table.Random(nilfpos)), nil, game.GetMap()},
	["Нелидка (Нейтрал)"] = {tonumber(table.Random(nelidpos)), nil, game.GetMap()},
	["Бибки (Нейтрал)"] = {tonumber(table.Random(bibpos)), nil, game.GetMap()},
	["Случайное"] = {tonumber(table.Random(randompos)), nil, game.GetMap()}	
	}
	if data then
		character:setData("pos", position[data.spawnplace])
	end
end
/*
			DComboBox:AddChoice( "Майенна (Темерия)" )
			DComboBox:AddChoice( "Подворенга (Нильфгаард)" )
			DComboBox:AddChoice( "Нелидка (Нейтрал)" )
			DComboBox:AddChoice( "Бибки (Нейтрал)" )
			DComboBox:AddChoice( "Случайное", nil, true)
*/
nut.util.include("sh_config.lua")
nut.util.include("sh_commands.lua")
nut.util.include("sh_emotes.lua")
nut.util.includeDir("hooks")
nut.util.includeDir("meta")

nut.flag.add("T", "Доступ к обучению персонажей.")

nut.currency.set("", "орен", "орена", "оренов")
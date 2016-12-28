local data_entity = {}

for type,elements in pairs(data.raw) do
	if type =="item" then
		for _,element in pairs(elements) do
			local entity = {}
			entity.type = element.type
			data_entity[element.name] = entity
		end
	end
end

for type,elements in pairs(data.raw) do
	if type ~="item" then
		for _,element in pairs(elements) do
			if element.name ~= nil and element.type ~= "recipe" then
				local entity = data_entity[element.name]
				if entity ~= nil then
					if element.crafting_categories ~= nil then entity.crafting_categories = element.crafting_categories end
					if element.resource_categories ~= nil then entity.resource_categories = element.resource_categories end
					if element.crafting_speed ~= nil then entity.crafting_speed = element.crafting_speed end
					if element.energy_usage ~= nil then entity.energy_usage = element.energy_usage end
					if element.ingredient_count ~= nil then entity.ingredient_count = element.ingredient_count end
					if element.module_specification ~= nil then entity.module_specification = element.module_specification end
					if element.mining_power ~= nil then entity.mining_power = element.mining_power end
					if element.distribution_effectivity ~= nil then entity.efficiency = element.distribution_effectivity end
					if element.mining_speed ~= nil then entity.mining_speed = element.mining_speed end
					if element.mining_power ~= nil then entity.mining_power = element.mining_power end
					if element.pumping_speed ~= nil then
						-- a priori uniquement dans le cas water
						entity.mining_speed = element.pumping_speed
						entity.mining_power = 1
						if entity.resource_categories == nil then entity.resource_categories = {} end
						table.insert(entity.resource_categories,"offshore-pump")
					end
				end
			end
		end
	end
end

data:extend({{
	type = "flying-text",
	name = "data_entity",
	time_to_live = 0,
	speed = 1,
	order = serpent.dump(data_entity)
}})
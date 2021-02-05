return {

	ParameterGenerator = function()
		return
	end;

	Functions = {
        ["Sample A"] = function(Profiler)
            local min = Vector3.new(0, 0, 0)
            local max = Vector3.new(1, 1, 1)
            local theta = 100

            local x = math.random(min.X * theta, max.X * theta) / theta
            local y = math.random(min.Y * theta, max.Y * theta) / theta
            local z = math.random(min.Z * theta, max.Z * theta) / theta
        
            return Vector3.new(x, y, z)
		end;

        ["Sample B"] = function(Profiler)
            local min = Vector3.new(0, 0, 0)
            local max = Vector3.new(1, 1, 1)
            
            local x = Random.new():NextNumber(min.X, max.X)
            local y = Random.new():NextNumber(min.Y, max.Y)
            local z = Random.new():NextNumber(min.Z, max.Z)
        
            return Vector3.new(x, y, z)
		end;
	};

}
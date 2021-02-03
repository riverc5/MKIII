local Animations = require(game:GetService("ReplicatedStorage").Modules.Animations)
local Animator = workspace.Dummy.Humanoid.Animator
local AnimationTracks = workspace.AnimationTracks:GetDescendants()

return {

	ParameterGenerator = function()
		return
	end;

	Functions = {
        ["Sample A"] = function(Profiler)
            local anims = Animations:Setup(Animator, workspace.AnimationTracks:GetDescendants())
		end,

        ["Sample B"] = function(Profiler)
            local anims = Animations:_BENCHMARKINGSetup2(Animator, workspace.AnimationTracks:GetDescendants())
        end,
	};

}
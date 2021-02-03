local Chat = game:GetService("Chat")

Chat:SetBubbleChatSettings({
	-- The amount of time, in seconds, to wait before a bubble fades out.
	BubbleDuration = 15,

	-- The amount of messages to be displayed, before old ones disappear
	-- immediately when a new message comes in.
	MaxBubbles = 3,

	-- Styling for the bubbles. These settings will change various visual aspects.
	BackgroundColor3 = Color3.fromRGB(12, 12, 12),
	TextColor3 = Color3.fromRGB(245, 245, 245),
	TextSize = 16,
	Font = Enum.Font.SourceSansSemibold,
	Transparency = 0.2,
	CornerRadius = UDim.new(0, 14),
	TailVisible = true,
	Padding = 7.5, -- in pixels
	MaxWidth = 310, --in pixels

	-- Extra space between the head and the billboard (useful if you want to
	-- leave some space for other character billboard UIs)
	VerticalStudsOffset = 0.1,

	-- Space in pixels between two bubbles
	BubblesSpacing = 3,

	-- The distance (from the camera) that bubbles turn into a single bubble
	-- with ellipses (...) to indicate chatter.
	MinimizeDistance = 60,
	-- The max distance (from the camera) that bubbles are shown at
	MaxDistance = 120,
})
--- @meta

--- Play a sound effect (0 to 63) on a channel (0 to 15) from note offset (0 to 63 in notes) for length notes
--- [View Online](https://www.lexaloffle.com/dl/docs/picotron_manual.html#sfx)
--- @param n integer
--- @param channel? integer
--- @param offset? integer
--- @param length? integer
function sfx(n, channel, offset, length) end

--- Plays music starting from pattern n.
--- If n is -1, stop music
--- fade_len is in ms (default 0)
--- channel_mask is bitfield that specifies which channels to reserve for music only, low bits first
--- @param n integer
--- @param fade_len? integer
--- @param channel_mask? integer
function music(n, fade_len, channel_mask) end

--- This provides low level control over a channel. It is useful in more niche situations, like audio authoring tools and size-coding.
--- Internally this is what is used to play each row of a sfx when one is active. Use 0xff to indicate an attribute should not be altered.
---     pitch     channel pitch (default 48 -- middle C)
---     inst      instrument index (default 0)
---     vol       channel volume (default 64)
---     effect    channel effect (default 0)
---     effect_p  effect parameter (default 0)
---     channel   channel index (0..15 -- default 0)
---     retrig    (boolean) force retrigger -- default to false
---     panning   set channel panning (-128..127)
--- [View Online](https://www.lexaloffle.com/dl/docs/picotron_manual.html#note)
--- @param pitch integer
--- @param inst integer
--- @param vol integer
--- @param effect integer
--- @param effect_p integer
--- @param channel integer
--- @param retrig boolean
--- @param panning integer
function note(pitch, inst, vol, effect, effect_p, channel, retrig, panning) end

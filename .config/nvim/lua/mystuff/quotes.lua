-- A small collection of quotes shown on the dashboard splash screen.
-- Add your own freely: each entry is { text, author }.
local quotes = {
	{ "In social settings, you'll never make a good impression on people until you stop trying so hard to make a good impression", "C.S. Lewis" },
	{ "If God is satisfied with the work, the work may be satisfied with itself", "C.S. Lewis" },
	{ "The Christian ideal has not been tried and found wanting. It has been found difficult; and left untried", "G.K. Chesterton" },
	{ "God doesn't need your good works but your neighbor does", "Martin Luther" },
	{ "God is most glorified in us when we are most satisfied in Him", "John Piper" },
	{ "There's more to life than increasing its speed", "Gandhi" },
	{ "I would rather get to heaven and find out I was more naive about others than cynical", "Kevin DeYoung" },
	{ "Anything worth doing is worth doing badly", "G.K. CHesterton" },
	{ "Anything worth doing is worth doing poorly", "G.K. Chesterton" },
	{ "Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away.", "Antoine de Saint-Exupery" },
	{ "It always seems impossible until it's done.", "Nelson Mandela" },
	{ "When I utter a word, it hath dominion over me; but when I utter it not, I have dominion over it", "Persian Poet" },
	{ "You cannot be envious of someone unless you are first proud of yourself", "John Stott" },
	{ "Love is never self-seeking, for in whatever a person seeks himself there he falls from love", "Thomas à Kempis" },
	{ "And whatever you do, do it heartily, as to the Lord and not to menm knowing that from the Lord you will receive the reward of the inheritance; for you serve the Lord Christ", "Colossians 3:23-24 (NKJV)" },
	{ "Simplicity is the soul of efficiency.", "Austin Freeman" },
	{ "First, solve the problem. Then, write the code.", "John Johnson" },
	{ "Make it work, make it right, make it fast.", "Kent Beck" },
	{ "Code is like humor. When you have to explain it, it's bad.", "Cory House" },
}

local M = {}

function M.random()
	math.randomseed(os.time() + (vim.loop and vim.loop.hrtime() or 0))
	local q = quotes[math.random(#quotes)]
	return q[1], q[2]
end

return M

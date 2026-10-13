-- A small collection of quotes shown on the dashboard splash screen.
-- Add your own freely: each entry is { text, author }.
local quotes = {
	{ "The only way to do great work is to love what you do.", "Steve Jobs" },
	{ "Simplicity is the soul of efficiency.", "Austin Freeman" },
	{ "First, solve the problem. Then, write the code.", "John Johnson" },
	{ "Make it work, make it right, make it fast.", "Kent Beck" },
	{ "Programs must be written for people to read, and only incidentally for machines to execute.", "Harold Abelson" },
	{ "Talk is cheap. Show me the code.", "Linus Torvalds" },
	{ "Any fool can write code that a computer can understand. Good programmers write code that humans can understand.", "Martin Fowler" },
	{ "Premature optimization is the root of all evil.", "Donald Knuth" },
	{ "The best way to predict the future is to invent it.", "Alan Kay" },
	{ "Code is like humor. When you have to explain it, it's bad.", "Cory House" },
	{ "Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away.", "Antoine de Saint-Exupery" },
	{ "It always seems impossible until it's done.", "Nelson Mandela" },
	{ "Do or do not. There is no try.", "Yoda" },
	{ "Fall seven times, stand up eight.", "Japanese Proverb" },
	{ "Whether you think you can or you think you can't, you're right.", "Henry Ford" },
}

local M = {}

function M.random()
	math.randomseed(os.time() + (vim.loop and vim.loop.hrtime() or 0))
	local q = quotes[math.random(#quotes)]
	return q[1], q[2]
end

return M

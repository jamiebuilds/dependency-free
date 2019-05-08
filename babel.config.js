module.exports = api => {
	api.cache(false)
	return {
		presets: [
			require("@babel/preset-env"),
			require("@babel/preset-react"),
			require("@babel/preset-typescript"),
		],
	}
}

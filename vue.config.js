module.exports = {
    publicPath: '.',
    transpileDependencies: ['vue-mapbox'],
    chainWebpack: (config) => {
        const svgRule = config.module.rule('svg');
        svgRule.uses.clear();
        svgRule
            .use('babel-loader')
            .loader('babel-loader')
            .end()
            .use('vue-svg-loader')
            .loader('vue-svg-loader');

        /*
            As described on StackOverflow:
            https://stackoverflow.com/questions/64205612/how-to-correct-preload-key-requests-performance-problem-on-lighthouse-with-vue
            But is in a webpack chain:
            https://github.com/neutrinojs/webpack-chain#config-output-shorthand-methods
        */
        config.output
            .crossOriginLoading('anonymous');
    }
};

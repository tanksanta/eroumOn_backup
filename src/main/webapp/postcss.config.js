module.exports = {
    plugins: {
        'postcss-import': {},
        'postcss-easings': {},
        'tailwindcss/nesting': 'postcss-nesting',
        'tailwindcss': {},
        'postcss-mixins': {},
        "cssnano": {
            "discardComments": {
                "removeAll": true
            }
        }
    }
}
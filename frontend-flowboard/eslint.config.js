import vue from 'eslint-plugin-vue'
import ts from '@typescript-eslint/eslint-plugin'
import tsParser from '@typescript-eslint/parser'
import prettierPlugin from 'eslint-plugin-prettier'

export default [
  {
    files: ['**/*.ts', '**/*.tsx', '**/*.vue'],
    languageOptions: {
      parser: tsParser,
      sourceType: 'module',
      ecmaVersion: 'latest'
    },

    plugins: {
      vue,
      '@typescript-eslint': ts,
      prettier: prettierPlugin
    },

    extends: [
      'eslint:recommended',
      'plugin:vue/vue3-recommended',
      'plugin:@typescript-eslint/recommended',
      'prettier',
      'plugin:prettier/recommended'
    ],

    env: {
      browser: true,
      es2021: true
    },

    parserOptions: {
      ecmaVersion: 2021,
      sourceType: 'module'
    },

    rules: {
      'prettier/prettier': ['error', { singleQuote: true, semi: false }],

      'vue/multi-word-component-names': 'off',
      'vue/html-indent': ['error', 2],
      'vue/no-unused-components': 'warn',
      'vue/no-multiple-template-root': 'off',

      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],

      'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
      'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off'
    }
  }
]

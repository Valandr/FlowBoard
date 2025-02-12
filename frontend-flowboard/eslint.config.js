import vue from 'eslint-plugin-vue'
import ts from '@typescript-eslint/eslint-plugin'
import tsParser from '@typescript-eslint/parser'
import prettier from 'eslint-config-prettier'

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
      '@typescript-eslint': ts
    },
    rules: {
      // Vue
      'vue/multi-word-component-names': 'off',
      'vue/html-indent': ['error', 2],
      'vue/no-unused-components': 'warn',
      'vue/no-multiple-template-root': 'off',

      // TypeScript
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-unused-vars': 'warn',

      // Général
      'no-console': 'warn',
      'no-debugger': 'error'
    }
  },
  prettier
]

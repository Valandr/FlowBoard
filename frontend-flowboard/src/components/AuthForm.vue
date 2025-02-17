<script setup lang="ts">
import { ref } from 'vue'

defineProps<{
  title: string
  submitLabel: string
  onSubmit: (email: string, password: string, passwordConfirmation?: string) => void
  isSignup?: boolean
}>()

const email = ref('')
const password = ref('')
const passwordConfirmation = ref('')
</script>

<template>
  <div class="p-8 bg-white rounded-lg shadow-md w-96">
    <h1 class="text-2xl font-bold mb-4">{{ title }}</h1>
    <input
      v-model="email"
      type="email"
      placeholder="Email"
      class="border p-2 rounded w-full mb-2"
    />
    <input
      v-model="password"
      type="password"
      placeholder="password"
      class="border p-2 rounded w-full mb-2"
    />
    <input
      v-if="isSignup"
      v-model="passwordConfirmation"
      type="password"
      placeholder="Confirmer le password"
      class="border p-2 rounded w-full mb-2"
    />
    <button
      @click="onSubmit(email, password, passwordConfirmation)"
      class="bg-blue-500 text-white px-4 py-2 rounded w-full"
    >
      {{ submitLabel }}
    </button>
  </div>
</template>

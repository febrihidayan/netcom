<script setup lang="ts">
import { Head, Link, router } from '@inertiajs/vue3';
import { reactive } from 'vue';

const props = defineProps<{
    title: string;
    resource: string;
    fields: string[];
    formFields?: string[];
    labels?: Record<string, string>;
    options?: Record<string, { value: string; label: string }[]>;
}>();

const inputFields = props.formFields ?? props.fields;

const form = reactive<Record<string, any>>({});
inputFields.forEach((f) => (form[f] = ''));

function isDateTime(field: string): boolean {
    return /date|timestamp|_at$/i.test(field);
}

function submit() {
    router.post(`/${props.resource}`, form);
}
</script>

<template>
    <Head :title="`Create ${title}`" />
    <div class="p-6">
        <Link :href="`/${resource}`" class="mb-4 inline-block text-blue-600">← Back</Link>
        <h1 class="mb-4 text-2xl font-bold">Create {{ title }}</h1>
        <form @submit.prevent="submit" class="space-y-4">
            <div v-for="field in inputFields" :key="field">
                <label class="block text-sm font-medium">{{ props.labels?.[field] ?? field }}</label>
                <select
                    v-if="options && options[field]"
                    v-model="form[field]"
                    class="w-full rounded border px-3 py-2"
                >
                    <option value="">Select</option>
                    <option v-for="opt in options[field]" :key="opt.value" :value="opt.value">
                        {{ opt.label }}
                    </option>
                </select>
                <input
                    v-else
                    v-model="form[field]"
                    :type="isDateTime(field) ? 'datetime-local' : 'text'"
                    class="w-full rounded border px-3 py-2"
                />
            </div>
            <button type="submit" class="rounded bg-blue-600 px-4 py-2 text-white">Save</button>
        </form>
    </div>
</template>
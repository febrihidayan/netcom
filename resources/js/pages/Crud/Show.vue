<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3';

const props = defineProps<{
    title: string;
    resource: string;
    fields: string[];
    labels?: Record<string, string>;
    item: Record<string, any>;
}>();

function formatValue(value: any): string {
    if (value === null || value === undefined) return '';
    if (typeof value === 'string' && /^\d{4}-\d{2}-\d{2}(T|\s)\d{2}:\d{2}/.test(value)) {
        const date = new Date(value);
        if (!isNaN(date.getTime())) {
            return date.toLocaleString();
        }
    }
    return String(value);
}
</script>

<template>
    <Head :title="title" />
    <div class="p-6">
        <h1 class="mb-4 text-2xl font-bold">{{ title }}</h1>
        <dl class="space-y-2">
            <div v-for="field in fields" :key="field">
                <dt class="font-semibold">{{ props.labels?.[field] ?? field }}</dt>
                <dd>{{ formatValue(item[field]) }}</dd>
            </div>
        </dl>
        <Link :href="`/${resource}`" class="mt-4 inline-block text-blue-600">Back</Link>
    </div>
</template>
<script setup lang="ts">
import { Head, Link, router } from '@inertiajs/vue3';
import { ref } from 'vue';

const props = defineProps<{
    title: string;
    resource: string;
    fields: string[];
    keyField?: string;
    labels?: Record<string, string>;
    items: { data: Record<string, any>[]; links: any[]; from?: number; to?: number; total?: number; per_page?: number };
    filters?: { search?: string; per_page?: number };
}>();

const keyField = props.keyField ?? props.fields[0] ?? 'id';

const search = ref(props.filters?.search ?? '');
const perPage = ref(props.filters?.per_page ?? props.items.per_page ?? 15);

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

function applyFilters() {
    router.get(`/${props.resource}`, {
        search: search.value,
        per_page: perPage.value,
    });
}
</script>

<template>
    <Head :title="title" />
    <div class="p-6">
        <div class="mb-4 flex items-center justify-between">
            <h1 class="text-2xl font-bold">{{ title }}</h1>
            <Link :href="`/${resource}/create`" class="rounded bg-blue-600 px-4 py-2 text-white">
                Create
            </Link>
        </div>

        <div class="mb-4 flex flex-wrap items-end gap-3">
            <div>
                <label class="block text-sm font-medium">Search</label>
                <input
                    v-model="search"
                    type="text"
                    class="rounded border px-3 py-2"
                    @keyup.enter="applyFilters"
                />
            </div>
            <div>
                <label class="block text-sm font-medium">Per Page</label>
                <select v-model="perPage" class="rounded border px-3 py-2" @change="applyFilters">
                    <option :value="10">10</option>
                    <option :value="15">15</option>
                    <option :value="25">25</option>
                    <option :value="50">50</option>
                </select>
            </div>
            <button
                type="button"
                class="rounded bg-blue-600 px-4 py-2 text-white"
                @click="applyFilters"
            >
                Apply
            </button>
        </div>

        <table class="w-full border-collapse border">
            <thead>
                <tr>
                    <th class="border px-2 py-1 text-left">No</th>
                    <th v-for="field in fields" :key="field" class="border px-2 py-1 text-left">
                        {{ labels?.[field] ?? field }}
                    </th>
                    <th class="border px-2 py-1">Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(item, idx) in items.data" :key="item[keyField]">
                    <td class="border px-2 py-1">
                        {{ (items.from ?? 1) + idx }}
                    </td>
                    <td v-for="field in fields" :key="field" class="border px-2 py-1">
                        {{ formatValue(item[field]) }}
                    </td>
                    <td class="border px-2 py-1">
                        <Link :href="`/${resource}/${item[keyField]}/edit`" class="mr-2 text-blue-600">
                            Edit
                        </Link>
                        <button
                            class="text-red-600"
                            @click="router.delete(`/${resource}/${item[keyField]}`)"
                        >
                            Delete
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="mt-4 flex flex-wrap items-center gap-2">
            <template v-for="(link, idx) in items.links" :key="idx">
                <Link
                    v-if="link.url"
                    :href="link.url"
                    class="rounded border px-3 py-1 text-sm"
                    :class="{ 'bg-blue-600 text-white': link.active }"
                    v-html="link.label"
                />
                <span
                    v-else
                    class="rounded border px-3 py-1 text-sm text-muted-foreground"
                    v-html="link.label"
                />
            </template>
        </div>
    </div>
</template>
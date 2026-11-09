<script setup lang="ts">
import { Head, router } from '@inertiajs/vue3';
import { computed, ref } from 'vue';

defineOptions({
    layout: {
        breadcrumbs: [
            {
                title: 'Dashboard',
                href: '/dashboard',
            },
        ],
    },
});

const props = defineProps<{
    year: number;
    month: number;
    years: number[];
    daily: { date: string; revenue: number }[];
    anomalies: { date: string; revenue: number; type: string }[];
    totalRevenue: number;
    averageRevenue: number;
    undeliveredOrders: { id: string; status: string; customer: string; purchase_date: string; estimated_delivery: string }[];
}>();

const selectedYear = ref(props.year);
const selectedMonth = ref(props.month);

const maxRevenue = computed(() => Math.max(...props.daily.map((d) => d.revenue), 1));

function applyFilter() {
    router.get('/dashboard', {
        year: selectedYear.value,
        month: selectedMonth.value,
    });
}

function formatMoney(value: number): string {
    return new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR' }).format(value);
}

const monthNames = [
    'January','February','March','April','May','June',
    'July','August','September','October','November','December',
];
</script>

<template>
    <Head title="Dashboard" />

    <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
        <div class="flex flex-wrap items-end gap-3">
            <div>
                <label class="block text-sm font-medium">Month</label>
                <select v-model="selectedMonth" class="rounded border px-3 py-2">
                    <option v-for="(name, idx) in monthNames" :key="idx" :value="idx + 1">
                        {{ name }}
                    </option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium">Year</label>
                <select v-model="selectedYear" class="rounded border px-3 py-2">
                    <option v-for="y in years" :key="y" :value="y">{{ y }}</option>
                </select>
            </div>
            <button
                type="button"
                class="rounded bg-blue-600 px-4 py-2 text-white"
                @click="applyFilter"
            >
                Apply
            </button>
        </div>

        <div class="grid gap-4 md:grid-cols-3">
            <div class="rounded-xl border p-4">
                <div class="text-sm text-muted-foreground">Total Revenue</div>
                <div class="text-2xl font-bold">{{ formatMoney(totalRevenue) }}</div>
            </div>
            <div class="rounded-xl border p-4">
                <div class="text-sm text-muted-foreground">Average Daily Revenue</div>
                <div class="text-2xl font-bold">{{ formatMoney(averageRevenue) }}</div>
            </div>
            <div class="rounded-xl border p-4">
                <div class="text-sm text-muted-foreground">Anomalies Detected</div>
                <div class="text-2xl font-bold">{{ anomalies.length }}</div>
            </div>
        </div>

        <div class="rounded-xl border p-4">
            <h2 class="mb-4 text-lg font-semibold">Daily Revenue - {{ monthNames[month - 1] }} {{ year }}</h2>
            <div class="flex items-end gap-1 overflow-x-auto" style="min-height: 220px;">
                <div
                    v-for="d in daily"
                    :key="d.date"
                    class="flex flex-col items-center"
                    style="min-width: 28px;"
                >
                    <div
                        class="w-5 rounded-t bg-blue-500"
                        :style="{ height: (d.revenue / maxRevenue) * 180 + 'px' }"
                        :title="`${d.date}: ${formatMoney(d.revenue)}`"
                    ></div>
                    <div class="mt-1 text-xs text-muted-foreground">
                        {{ d.date.slice(8, 10) }}
                    </div>
                </div>
            </div>
        </div>

        <div class="rounded-xl border p-4">
            <h2 class="mb-2 text-lg font-semibold">Revenue Anomalies</h2>
            <div v-if="anomalies.length === 0" class="text-sm text-muted-foreground">
                No anomalies detected.
            </div>
            <ul v-else class="space-y-2">
                <li
                    v-for="a in anomalies"
                    :key="a.date"
                    class="flex items-center justify-between rounded border px-3 py-2"
                >
                    <span>{{ a.date }}</span>
                    <span :class="a.type === 'high' ? 'text-green-600' : 'text-red-600'">
                        {{ formatMoney(a.revenue) }} ({{ a.type }})
                    </span>
                </li>
            </ul>
        </div>

        <div class="rounded-xl border p-4">
            <h2 class="mb-2 text-lg font-semibold">Orders Not Yet Delivered</h2>
            <div v-if="undeliveredOrders.length === 0" class="text-sm text-muted-foreground">
                All orders have been delivered.
            </div>
            <table v-else class="w-full border-collapse border text-sm">
                <thead>
                    <tr>
                        <th class="border px-2 py-1 text-left">Customer</th>
                        <th class="border px-2 py-1 text-left">Status</th>
                        <th class="border px-2 py-1 text-left">Purchase Date</th>
                        <th class="border px-2 py-1 text-left">Estimated Delivery</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="o in undeliveredOrders" :key="o.id">
                        <td class="border px-2 py-1">{{ o.customer }}</td>
                        <td class="border px-2 py-1">{{ o.status }}</td>
                        <td class="border px-2 py-1">{{ o.purchase_date }}</td>
                        <td class="border px-2 py-1">{{ o.estimated_delivery }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>
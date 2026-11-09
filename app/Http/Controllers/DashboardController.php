<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $year = (int) $request->input('year', now()->year);
        $month = (int) $request->input('month', now()->month);

        $start = now()->setYear($year)->setMonth($month)->startOfMonth();
        $end = (clone $start)->endOfMonth();

        $rows = DB::table('order_items')
            ->join('orders', 'order_items.order_id', '=', 'orders.id')
            ->whereBetween('orders.order_purchase_timestamp', [$start, $end])
            ->selectRaw('DATE(orders.order_purchase_timestamp) as date, SUM(order_items.price) as revenue')
            ->groupBy('date')
            ->orderBy('date')
            ->get()
            ->keyBy('date');

        $daysInMonth = $start->daysInMonth;
        $daily = [];
        for ($d = 1; $d <= $daysInMonth; $d++) {
            $date = $start->copy()->day($d)->toDateString();
            $daily[] = [
                'date' => $date,
                'revenue' => (float) ($rows[$date]->revenue ?? 0),
            ];
        }

        $revenues = array_column($daily, 'revenue');
        $mean = count($revenues) ? array_sum($revenues) / count($revenues) : 0;
        $variance = 0;
        foreach ($revenues as $r) {
            $variance += ($r - $mean) ** 2;
        }
        $std = count($revenues) ? sqrt($variance / count($revenues)) : 0;

        $anomalies = [];
        foreach ($daily as $row) {
            if ($std > 0 && (abs($row['revenue'] - $mean) > 2 * $std)) {
                $anomalies[] = [
                    'date' => $row['date'],
                    'revenue' => $row['revenue'],
                    'type' => $row['revenue'] > $mean ? 'high' : 'low',
                ];
            }
        }

        $years = range(now()->year - 3, now()->year + 1);

        $undelivered = Order::with('customer')
            ->whereNull('order_delivered_customer_date')
            ->orderByDesc('order_purchase_timestamp')
            ->limit(20)
            ->get()
            ->map(fn ($o) => [
                'id' => $o->id,
                'status' => $o->order_status,
                'customer' => $o->customer?->customer_name ?? '-',
                'purchase_date' => optional($o->order_purchase_timestamp)->format('Y-m-d H:i'),
                'estimated_delivery' => optional($o->order_estimated_delivery_date)->format('Y-m-d'),
            ]);

        return Inertia::render('Dashboard', [
            'year' => $year,
            'month' => $month,
            'years' => array_values($years),
            'daily' => $daily,
            'anomalies' => $anomalies,
            'totalRevenue' => array_sum($revenues),
            'averageRevenue' => $mean,
            'undeliveredOrders' => $undelivered,
        ]);
    }
}
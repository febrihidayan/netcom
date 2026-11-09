<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use App\Models\Order;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OrderController extends Controller
{
    protected array $tableFields = ['order_status','order_purchase_timestamp','order_approved_at','order_delivered_carrier_date','order_delivered_customer_date','order_estimated_delivery_date'];
    protected array $formFields = ['customer_id','order_status','order_purchase_timestamp','order_approved_at','order_delivered_carrier_date','order_delivered_customer_date','order_estimated_delivery_date'];
    protected array $labels = [
        'customer_id' => 'Customer',
        'order_status' => 'Status',
        'order_purchase_timestamp' => 'Purchase Date',
        'order_approved_at' => 'Approved At',
        'order_delivered_carrier_date' => 'Delivered to Carrier',
        'order_delivered_customer_date' => 'Delivered to Customer',
        'order_estimated_delivery_date' => 'Estimated Delivery',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = Order::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('order_status', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Orders',
            'resource' => 'orders',
            'fields' => $this->tableFields,
            'keyField' => 'id',
            'labels' => $this->labels,
            'items' => $query->paginate($perPage)->withQueryString(),
            'filters' => ['search' => $search, 'per_page' => $perPage],
        ]);
    }

    public function create()
    {
        return Inertia::render('Crud/Create', [
            'title' => 'Order',
            'resource' => 'orders',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'options' => [
                'customer_id' => Customer::all()->map(fn ($c) => [
                    'value' => $c->id,
                    'label' => ($c->customer_name ?? 'Customer').' - '.$c->customer_city,
                ])->values()->all(),
                'order_status' => collect(['pending','approved','shipped','delivered','canceled'])->map(fn ($s) => [
                    'value' => $s,
                    'label' => ucfirst($s),
                ])->values()->all(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'customer_id' => 'required|uuid',
            'order_status' => 'required|string|max:50',
            'order_purchase_timestamp' => 'nullable|date',
            'order_approved_at' => 'nullable|date',
            'order_delivered_carrier_date' => 'nullable|date',
            'order_delivered_customer_date' => 'nullable|date',
            'order_estimated_delivery_date' => 'nullable|date',
        ]);

        Order::create($validated);

        return redirect()->route('orders.index');
    }

    public function show(Order $order)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Order',
            'resource' => 'orders',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $order,
        ]);
    }

    public function edit(Order $order)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Order',
            'resource' => 'orders',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $order,
            'options' => [
                'customer_id' => Customer::all()->map(fn ($c) => [
                    'value' => $c->id,
                    'label' => ($c->customer_name ?? 'Customer').' - '.$c->customer_city,
                ])->values()->all(),
                'order_status' => collect(['pending','approved','shipped','delivered','canceled'])->map(fn ($s) => [
                    'value' => $s,
                    'label' => ucfirst($s),
                ])->values()->all(),
            ],
        ]);
    }

    public function update(Request $request, Order $order)
    {
        $validated = $request->validate([
            'customer_id' => 'required|uuid',
            'order_status' => 'required|string|max:50',
            'order_purchase_timestamp' => 'nullable|date',
            'order_approved_at' => 'nullable|date',
            'order_delivered_carrier_date' => 'nullable|date',
            'order_delivered_customer_date' => 'nullable|date',
            'order_estimated_delivery_date' => 'nullable|date',
        ]);

        $order->update($validated);

        return redirect()->route('orders.index');
    }

    public function destroy(Order $order)
    {
        $order->delete();

        return redirect()->route('orders.index');
    }
}
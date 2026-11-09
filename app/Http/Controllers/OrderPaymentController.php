<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderPayment;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OrderPaymentController extends Controller
{
    protected array $tableFields = ['payment_sequential','payment_type','payment_installments','payment_value'];
    protected array $formFields = ['order_id','payment_sequential','payment_type','payment_installments','payment_value'];
    protected array $labels = [
        'order_id' => 'Order',
        'payment_sequential' => 'Sequential',
        'payment_type' => 'Payment Type',
        'payment_installments' => 'Installments',
        'payment_value' => 'Value',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = OrderPayment::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('payment_type', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Order Payments',
            'resource' => 'order-payments',
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
            'title' => 'Order Payment',
            'resource' => 'order-payments',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'options' => [
                'order_id' => Order::all()->map(fn ($o) => [
                    'value' => $o->id,
                    'label' => $o->order_status.' - '.optional($o->order_purchase_timestamp)->format('Y-m-d'),
                ])->values()->all(),
                'payment_type' => collect(['credit_card','boleto','voucher','debit_card'])->map(fn ($t) => [
                    'value' => $t,
                    'label' => ucfirst(str_replace('_', ' ', $t)),
                ])->values()->all(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'order_id' => 'required|uuid',
            'payment_sequential' => 'required|integer',
            'payment_type' => 'required|string|max:50',
            'payment_installments' => 'required|integer',
            'payment_value' => 'required|numeric',
        ]);

        OrderPayment::create($validated);

        return redirect()->route('order-payments.index');
    }

    public function show(OrderPayment $orderPayment)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Order Payment',
            'resource' => 'order-payments',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $orderPayment,
        ]);
    }

    public function edit(OrderPayment $orderPayment)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Order Payment',
            'resource' => 'order-payments',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $orderPayment,
            'options' => [
                'order_id' => Order::all()->map(fn ($o) => [
                    'value' => $o->id,
                    'label' => $o->order_status.' - '.optional($o->order_purchase_timestamp)->format('Y-m-d'),
                ])->values()->all(),
                'payment_type' => collect(['credit_card','boleto','voucher','debit_card'])->map(fn ($t) => [
                    'value' => $t,
                    'label' => ucfirst(str_replace('_', ' ', $t)),
                ])->values()->all(),
            ],
        ]);
    }

    public function update(Request $request, OrderPayment $orderPayment)
    {
        $validated = $request->validate([
            'order_id' => 'required|uuid',
            'payment_sequential' => 'required|integer',
            'payment_type' => 'required|string|max:50',
            'payment_installments' => 'required|integer',
            'payment_value' => 'required|numeric',
        ]);

        $orderPayment->update($validated);

        return redirect()->route('order-payments.index');
    }

    public function destroy(OrderPayment $orderPayment)
    {
        $orderPayment->delete();

        return redirect()->route('order-payments.index');
    }
}
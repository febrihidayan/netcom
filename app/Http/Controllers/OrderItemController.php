<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\Seller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OrderItemController extends Controller
{
    protected array $tableFields = ['order_item_id','price','freight_value','shipping_limit_date'];
    protected array $formFields = ['order_id','order_item_id','product_id','seller_id','shipping_limit_date','price','freight_value'];
    protected array $labels = [
        'order_id' => 'Order',
        'order_item_id' => 'Item #',
        'product_id' => 'Product',
        'seller_id' => 'Seller',
        'shipping_limit_date' => 'Shipping Limit Date',
        'price' => 'Price',
        'freight_value' => 'Freight Value',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = OrderItem::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('order_item_id', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Order Items',
            'resource' => 'order-items',
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
            'title' => 'Order Item',
            'resource' => 'order-items',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'options' => [
                'order_id' => Order::all()->map(fn ($o) => [
                    'value' => $o->id,
                    'label' => $o->order_status.' - '.optional($o->order_purchase_timestamp)->format('Y-m-d'),
                ])->values()->all(),
                'product_id' => Product::all()->map(fn ($p) => [
                    'value' => $p->id,
                    'label' => ($p->category?->product_category_name ?? 'Product').' - '.$p->product_weight_g.'g',
                ])->values()->all(),
                'seller_id' => Seller::all()->map(fn ($s) => [
                    'value' => $s->id,
                    'label' => $s->seller_city.' - '.$s->seller_state,
                ])->values()->all(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'order_id' => 'required|uuid',
            'order_item_id' => 'required|integer',
            'product_id' => 'required|uuid',
            'seller_id' => 'required|uuid',
            'shipping_limit_date' => 'nullable|date',
            'price' => 'required|numeric',
            'freight_value' => 'required|numeric',
        ]);

        OrderItem::create($validated);

        return redirect()->route('order-items.index');
    }

    public function show(OrderItem $orderItem)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Order Item',
            'resource' => 'order-items',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $orderItem,
        ]);
    }

    public function edit(OrderItem $orderItem)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Order Item',
            'resource' => 'order-items',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $orderItem,
            'options' => [
                'order_id' => Order::all()->map(fn ($o) => [
                    'value' => $o->id,
                    'label' => $o->order_status.' - '.optional($o->order_purchase_timestamp)->format('Y-m-d'),
                ])->values()->all(),
                'product_id' => Product::all()->map(fn ($p) => [
                    'value' => $p->id,
                    'label' => ($p->category?->product_category_name ?? 'Product').' - '.$p->product_weight_g.'g',
                ])->values()->all(),
                'seller_id' => Seller::all()->map(fn ($s) => [
                    'value' => $s->id,
                    'label' => $s->seller_city.' - '.$s->seller_state,
                ])->values()->all(),
            ],
        ]);
    }

    public function update(Request $request, OrderItem $orderItem)
    {
        $validated = $request->validate([
            'order_id' => 'required|uuid',
            'order_item_id' => 'required|integer',
            'product_id' => 'required|uuid',
            'seller_id' => 'required|uuid',
            'shipping_limit_date' => 'nullable|date',
            'price' => 'required|numeric',
            'freight_value' => 'required|numeric',
        ]);

        $orderItem->update($validated);

        return redirect()->route('order-items.index');
    }

    public function destroy(OrderItem $orderItem)
    {
        $orderItem->delete();

        return redirect()->route('order-items.index');
    }
}
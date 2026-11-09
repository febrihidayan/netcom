<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderReview;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OrderReviewController extends Controller
{
    protected array $tableFields = ['review_score','review_comment_title','review_creation_date'];
    protected array $formFields = ['order_id','review_score','review_comment_title','review_comment_message','review_creation_date','review_answer_timestamp'];
    protected array $labels = [
        'order_id' => 'Order',
        'review_score' => 'Score',
        'review_comment_title' => 'Title',
        'review_creation_date' => 'Created At',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = OrderReview::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('review_comment_title', 'like', "%{$search}%")
                    ->orWhere('review_comment_message', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Order Reviews',
            'resource' => 'order-reviews',
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
            'title' => 'Order Review',
            'resource' => 'order-reviews',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'options' => [
                'order_id' => Order::all()->map(fn ($o) => [
                    'value' => $o->id,
                    'label' => $o->order_status.' - '.optional($o->order_purchase_timestamp)->format('Y-m-d'),
                ])->values()->all(),
                'review_score' => collect([1,2,3,4,5])->map(fn ($s) => [
                    'value' => $s,
                    'label' => (string) $s,
                ])->values()->all(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'order_id' => 'required|uuid',
            'review_score' => 'required|integer|min:1|max:5',
            'review_comment_title' => 'nullable|string|max:255',
            'review_comment_message' => 'nullable|string',
            'review_creation_date' => 'nullable|date',
            'review_answer_timestamp' => 'nullable|date',
        ]);

        OrderReview::create($validated);

        return redirect()->route('order-reviews.index');
    }

    public function show(OrderReview $orderReview)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Order Review',
            'resource' => 'order-reviews',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $orderReview,
        ]);
    }

    public function edit(OrderReview $orderReview)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Order Review',
            'resource' => 'order-reviews',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $orderReview,
            'options' => [
                'order_id' => Order::all()->map(fn ($o) => [
                    'value' => $o->id,
                    'label' => $o->order_status.' - '.optional($o->order_purchase_timestamp)->format('Y-m-d'),
                ])->values()->all(),
                'review_score' => collect([1,2,3,4,5])->map(fn ($s) => [
                    'value' => $s,
                    'label' => (string) $s,
                ])->values()->all(),
            ],
        ]);
    }

    public function update(Request $request, OrderReview $orderReview)
    {
        $validated = $request->validate([
            'order_id' => 'required|uuid',
            'review_score' => 'required|integer|min:1|max:5',
            'review_comment_title' => 'nullable|string|max:255',
            'review_comment_message' => 'nullable|string',
            'review_creation_date' => 'nullable|date',
            'review_answer_timestamp' => 'nullable|date',
        ]);

        $orderReview->update($validated);

        return redirect()->route('order-reviews.index');
    }

    public function destroy(OrderReview $orderReview)
    {
        $orderReview->delete();

        return redirect()->route('order-reviews.index');
    }
}
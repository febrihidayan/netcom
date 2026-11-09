<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use App\Models\Geolocation;
use Illuminate\Http\Request;
use Inertia\Inertia;

class CustomerController extends Controller
{
    protected array $tableFields = ['customer_name','customer_city','customer_state','customer_zip_code_prefix'];
    protected array $formFields = ['customer_name','customer_zip_code_prefix','customer_city','customer_state'];
    protected array $labels = [
        'customer_name' => 'Name',
        'customer_city' => 'City',
        'customer_state' => 'State',
        'customer_zip_code_prefix' => 'Zip Code Prefix',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = Customer::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('customer_name', 'like', "%{$search}%")
                    ->orWhere('customer_city', 'like', "%{$search}%")
                    ->orWhere('customer_state', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Customers',
            'resource' => 'customers',
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
            'title' => 'Customer',
            'resource' => 'customers',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'options' => [
                'customer_zip_code_prefix' => Geolocation::all()->map(fn ($g) => [
                    'value' => $g->geolocation_zip_code_prefix,
                    'label' => $g->geolocation_zip_code_prefix.' - '.$g->geolocation_city,
                ])->values()->all(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'customer_name' => 'nullable|string|max:255',
            'customer_zip_code_prefix' => 'nullable|string|max:20',
            'customer_city' => 'nullable|string|max:255',
            'customer_state' => 'nullable|string|max:10',
        ]);

        Customer::create($validated);

        return redirect()->route('customers.index');
    }

    public function show(Customer $customer)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Customer',
            'resource' => 'customers',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $customer,
        ]);
    }

    public function edit(Customer $customer)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Customer',
            'resource' => 'customers',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $customer,
            'options' => [
                'customer_zip_code_prefix' => Geolocation::all()->map(fn ($g) => [
                    'value' => $g->geolocation_zip_code_prefix,
                    'label' => $g->geolocation_zip_code_prefix.' - '.$g->geolocation_city,
                ])->values()->all(),
            ],
        ]);
    }

    public function update(Request $request, Customer $customer)
    {
        $validated = $request->validate([
            'customer_name' => 'nullable|string|max:255',
            'customer_zip_code_prefix' => 'nullable|string|max:20',
            'customer_city' => 'nullable|string|max:255',
            'customer_state' => 'nullable|string|max:10',
        ]);

        $customer->update($validated);

        return redirect()->route('customers.index');
    }

    public function destroy(Customer $customer)
    {
        $customer->delete();

        return redirect()->route('customers.index');
    }
}
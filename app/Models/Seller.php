<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Seller extends Model
{
    use HasFactory;
    use HasUuids;

    protected $fillable = [
        'seller_zip_code_prefix',
        'seller_city',
        'seller_state',
    ];

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class, 'seller_id');
    }
}
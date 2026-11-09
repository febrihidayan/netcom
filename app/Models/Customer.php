<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Customer extends Model
{
    use HasFactory;
    use HasUuids;

    protected $fillable = [
        'customer_name',
        'customer_zip_code_prefix',
        'customer_city',
        'customer_state',
    ];

    public function geolocation(): BelongsTo
    {
        return $this->belongsTo(Geolocation::class, 'customer_zip_code_prefix', 'geolocation_zip_code_prefix');
    }

    public function orders(): HasMany
    {
        return $this->hasMany(Order::class, 'customer_id');
    }
}
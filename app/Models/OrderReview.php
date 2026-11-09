<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class OrderReview extends Model
{
    use HasFactory;
    use HasUuids;

    protected $fillable = [
        'order_id',
        'review_score',
        'review_comment_title',
        'review_comment_message',
        'review_creation_date',
        'review_answer_timestamp',
    ];

    protected $casts = [
        'review_creation_date' => 'datetime',
        'review_answer_timestamp' => 'datetime',
    ];

    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class, 'order_id');
    }
}
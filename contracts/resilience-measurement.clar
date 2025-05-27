;; Resilience Measurement Contract
;; Evaluates adaptive capacity

(define-constant ERR_UNAUTHORIZED (err u500))
(define-constant ERR_INVALID_MEASUREMENT (err u501))
(define-constant ERR_INFRASTRUCTURE_NOT_FOUND (err u502))

;; Resilience metrics data structure
(define-map resilience-metrics
  { infrastructure-id: uint }
  {
    redundancy-score: uint,
    recovery-time: uint,
    adaptation-speed: uint,
    failure-tolerance: uint,
    overall-resilience: uint,
    last-assessment: uint,
    assessor: principal
  }
)

;; Incident tracking for resilience calculation
(define-map incident-history
  { infrastructure-id: uint, incident-id: uint }
  {
    incident-type: (string-ascii 50),
    severity: uint,
    recovery-time: uint,
    impact-score: uint,
    timestamp: uint,
    resolved: bool
  }
)

(define-map incident-counters
  { infrastructure-id: uint }
  { count: uint }
)

;; Record incident
(define-public (record-incident
  (infrastructure-id uint)
  (incident-type (string-ascii 50))
  (severity uint)
  (impact-score uint)
)
  (let (
    (current-count (default-to u0 (get count (map-get? incident-counters { infrastructure-id: infrastructure-id }))))
    (incident-id (+ current-count u1))
  )
    (map-set incident-history
      { infrastructure-id: infrastructure-id, incident-id: incident-id }
      {
        incident-type: incident-type,
        severity: severity,
        recovery-time: u0,
        impact-score: impact-score,
        timestamp: block-height,
        resolved: false
      }
    )
    (map-set incident-counters
      { infrastructure-id: infrastructure-id }
      { count: incident-id }
    )
    (ok incident-id)
  )
)

;; Resolve incident and update recovery time
(define-public (resolve-incident
  (infrastructure-id uint)
  (incident-id uint)
  (recovery-time uint)
)
  (match (map-get? incident-history { infrastructure-id: infrastructure-id, incident-id: incident-id })
    incident
    (begin
      (map-set incident-history
        { infrastructure-id: infrastructure-id, incident-id: incident-id }
        (merge incident {
          recovery-time: recovery-time,
          resolved: true
        })
      )
      (ok true)
    )
    ERR_INVALID_MEASUREMENT
  )
)

;; Calculate resilience score
(define-public (calculate-resilience (infrastructure-id uint))
  (let (
    (incident-count (default-to u0 (get count (map-get? incident-counters { infrastructure-id: infrastructure-id }))))
    (redundancy-score u85)  ;; Base redundancy score
    (avg-recovery-time u120) ;; Average recovery time in blocks
    (adaptation-speed u75)   ;; Adaptation speed score
    (failure-tolerance (if (< incident-count u5) u90 u60)) ;; Based on incident frequency
  )
    (let (
      (overall-resilience (/ (+ redundancy-score adaptation-speed failure-tolerance) u3))
    )
      (map-set resilience-metrics
        { infrastructure-id: infrastructure-id }
        {
          redundancy-score: redundancy-score,
          recovery-time: avg-recovery-time,
          adaptation-speed: adaptation-speed,
          failure-tolerance: failure-tolerance,
          overall-resilience: overall-resilience,
          last-assessment: block-height,
          assessor: tx-sender
        }
      )
      (ok overall-resilience)
    )
  )
)

;; Get resilience metrics
(define-read-only (get-resilience-metrics (infrastructure-id uint))
  (map-get? resilience-metrics { infrastructure-id: infrastructure-id })
)

;; Get incident details
(define-read-only (get-incident (infrastructure-id uint) (incident-id uint))
  (map-get? incident-history { infrastructure-id: infrastructure-id, incident-id: incident-id })
)

;; Get incident count
(define-read-only (get-incident-count (infrastructure-id uint))
  (default-to u0 (get count (map-get? incident-counters { infrastructure-id: infrastructure-id })))
)

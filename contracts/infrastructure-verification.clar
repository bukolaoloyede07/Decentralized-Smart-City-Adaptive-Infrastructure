;; Infrastructure Verification Contract
;; Validates adaptive city systems

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_INVALID_INFRASTRUCTURE (err u101))
(define-constant ERR_ALREADY_VERIFIED (err u102))

;; Infrastructure data structure
(define-map infrastructures
  { infrastructure-id: uint }
  {
    name: (string-ascii 50),
    type: (string-ascii 20),
    location: (string-ascii 100),
    verified: bool,
    verification-date: uint,
    verifier: principal
  }
)

;; Verification status tracking
(define-data-var next-infrastructure-id uint u1)

;; Register new infrastructure
(define-public (register-infrastructure (name (string-ascii 50)) (type (string-ascii 20)) (location (string-ascii 100)))
  (let ((infrastructure-id (var-get next-infrastructure-id)))
    (map-set infrastructures
      { infrastructure-id: infrastructure-id }
      {
        name: name,
        type: type,
        location: location,
        verified: false,
        verification-date: u0,
        verifier: tx-sender
      }
    )
    (var-set next-infrastructure-id (+ infrastructure-id u1))
    (ok infrastructure-id)
  )
)

;; Verify infrastructure
(define-public (verify-infrastructure (infrastructure-id uint))
  (match (map-get? infrastructures { infrastructure-id: infrastructure-id })
    infrastructure
    (if (get verified infrastructure)
      ERR_ALREADY_VERIFIED
      (begin
        (map-set infrastructures
          { infrastructure-id: infrastructure-id }
          (merge infrastructure {
            verified: true,
            verification-date: block-height,
            verifier: tx-sender
          })
        )
        (ok true)
      )
    )
    ERR_INVALID_INFRASTRUCTURE
  )
)

;; Get infrastructure details
(define-read-only (get-infrastructure (infrastructure-id uint))
  (map-get? infrastructures { infrastructure-id: infrastructure-id })
)

;; Check if infrastructure is verified
(define-read-only (is-verified (infrastructure-id uint))
  (match (map-get? infrastructures { infrastructure-id: infrastructure-id })
    infrastructure (ok (get verified infrastructure))
    ERR_INVALID_INFRASTRUCTURE
  )
)

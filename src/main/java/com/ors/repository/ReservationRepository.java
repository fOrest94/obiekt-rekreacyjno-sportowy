package com.ors.repository;

import com.ors.model.ObjectDutyHours;
import com.ors.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by cos on 12.12.2016.
 */
public interface ReservationRepository  extends JpaRepository<Reservation, Long> {
    List<Reservation> findByUserId(Long userId);
}

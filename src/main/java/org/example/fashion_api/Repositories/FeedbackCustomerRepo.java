package org.example.fashion_api.Repositories;

import org.example.fashion_api.Models.FeedbackCustomers.FeedbackCustomer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface FeedbackCustomerRepo extends JpaRepository<FeedbackCustomer,Long> {




    @Modifying
    @Query(value = "UPDATE feedback_customers SET is_readed = true WHERE id = :id",
            nativeQuery = true)
    void setReadFeedback(@Param("id") Long id);

//    Integer countByReaded();

    @Modifying
    @Query(value = "UPDATE feedback_customers SET is_readed = false WHERE id = :id",
            nativeQuery = true)
    void setUnreadFeedback(@Param("id") Long id);
}

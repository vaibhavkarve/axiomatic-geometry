import .euclid
import tactic


-- Redo the local notation
--------------------------
local infix ` ≃ `:55 := congruent  -- typed as \ equiv
local infix `⬝`:56 := Segment.mk  -- typed as \ cdot


-- Lemma needed for Proposition 1
lemma hypothesis1_about_circles_radius (s : Segment) :
  let c₁ : Circle := ⟨s.p1, s.p2⟩ in
  let c₂ : Circle := ⟨s.p2, s.p1⟩ in
  radius c₁ + radius c₂ >= distance c₁.center c₂.center :=
begin
  intros,
  show distance s.p1 s.p2 ≤ radius c₁ + radius c₂,
    calc distance s.p1 s.p2 ≤ distance s.p1 s.p2 + distance s.p1 s.p2
                                              : by {simp, apply distance_not_neg}
         ... = radius c₁ + distance s.p1 s.p2 : by refl
         ... = radius c₁ + distance s.p2 s.p1 : by simp
         ... = radius c₁ + radius c₂ : by refl,
end


-- Another lemma needed for Proposition 1
lemma hypothesis2_about_circles_radius (s : Segment) :
  let c₁ : Circle := ⟨s.p1, s.p2⟩ in
  let c₂ : Circle := ⟨s.p2, s.p1⟩ in
  abs (radius c₁ - radius c₂) <= distance c₁.center c₂.center :=
  begin
    intros,
    show abs (radius c₁ - radius c₂) ≤ distance s.p1 s.p2,
    calc abs (radius c₁ - radius c₂) = abs (distance s.p1 s.p2 - radius c₂) : by refl
         ... = abs (distance s.p1 s.p2 - distance s.p2 s.p1) : by refl
         ... = abs (distance s.p1 s.p2 - distance s.p1 s.p2) : by simp
         ... = 0 : by simp
         ... ≤ distance s.p1 s.p2 : by apply distance_not_neg,
  end


-- # Proposition 1
------------------
lemma construct_equilateral (s : Segment) : ∃ (tri: Triangle),
  s.p1 = tri.p1 ∧ s.p2 = tri.p2 ∧ is_equilateral tri :=
begin
  set c₁ : Circle := ⟨s.p1, s.p2⟩,
  set c₂ : Circle := ⟨s.p2, s.p1⟩,
  have h₁ := (hypothesis1_about_circles_radius s),
  have h₂ := hypothesis2_about_circles_radius s,
  set p : Point := circles_intersect c₁ c₂ h₁ h₂,
  have hp₁ : p ∈ circumference c₁, from (circles_intersect' c₁ c₂ h₁ h₂).1,
  have hp₂ : p ∈ circumference c₂, from (circles_intersect' c₁ c₂ h₁ h₂).2,
  use ⟨s.p1, s.p2, p⟩,
  --- Cleaning up the context ---
    tidy;
    unfold circumference radius_segment at hp₁ hp₂;
    unfold sides_of_triangle;
    dsimp * at *,
  --- Cleaning done ---
    {calc s.p1 ⬝ s.p2 ≃ s.p2 ⬝ s.p1 : by symmetry
                  ... ≃ s.p2 ⬝ p    : by assumption},
    {calc s.p2 ⬝ p ≃ s.p2 ⬝ s.p1 : by {apply cong_symm, assumption}
               ... ≃ s.p1 ⬝ s.p2 : by apply segment_symm
               ... ≃ s.p1 ⬝ p    : by assumption
               ... ≃    p ⬝ s.p1 : by symmetry},
end


--Proposition 2
lemma placeline (s1 : Segment) (p1: Point): ∃ (s2 : Segment), (s1.p1 = s2.p1) ∧ congruent s1 s2 :=
begin
  sorry
end
--bruh moment

--Proposition 3
